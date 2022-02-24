# tf-deployment-demo

https://user-images.githubusercontent.com/6537446/155623422-16072e72-38b3-439d-8085-e689aa66028b.mov

## Repository Setup

1. Generate an RSA key to use for encrypting the Terraform binary plan.

   ```bash
   openssl genrsa -out private.pem 4096
   ```

1. Store the private key as a base64-encoded value as `ARTIFACT_ENCRYPTION_PRIKEY` in
GitHub repository secrets.

   ```bash
   cat private.pem | base64 # Paste into GitHub Secrets
   ```

## Basic workflow example

1. Ensure your local `staging` branch is up-to-date with `origin/staging`.

   ```bash
   git checkout staging && git fetch && git reset --hard origin/staging
   ```

1. From `staging`, create a topic branch for your new changes.

   ```bash
   git checkout -b myname/myfeature
   ```

1. Add Terraform code to `terraform/mymodule`.
1. Push the topic branch to GitHub.

   ```bash
   git push -u origin myname/myfeature
   ```

1. In the GitHub web UI (or `gh` CLI) create a Pull Request (PR) to merge your feature branch into `staging`.

1. Before merging, wait for the following checks to appear at the bottom of the PR.
   - `tf-deployment/plan-staging`
   - `tf-deployment/apply-staging`

1. The `github-actions [bot]` user will post the output of `terraform plan` as a comment on the PR.
  If the output is as expected, proceed to the next step. Otherwise, update your topic
  branch as needed. The plan output posted by `github-actions [bot]` will be
  updated on each push.

1. To begin the deployment, click *Details* to the right of the `tf-deployment/staging-apply` status check at the bottom of the PR. On the next screen, click *Review pending deployments*. On the dialog that appears, check the checkbox for the environment to add your approval, leave a comment if desired, then click *Approve and deploy*.

1. When the Deployment to `staging` is approved
   - The PR will be automatically merged.
   - Once the PR is merged, the `staging` environment will be deployed from the latest `staging` branch code.

1. If you are satisfied with the `staging` deployment, create a new PR to merge the `staging`
branch into `main`. Merging to `main` will deploy the `prod` environment. Follow the same
PR and Deployment approval procedure outlined above, but with `main` as the base branch
instead of `staging`.

### TODO

- [ ] Link to plan in TFE
- [ ] Wire up TFE backend
- [ ] Document or automate the proper sequence: Create PR => Approve Deployment => (`apply` workflow merges then runs `terraform apply`)
- [ ] Document how to use workflow_dispatch to deploy in case manual merge happens before deployment.
- [ ] Handle scenario where deployment is approved but `apply` job can't merge PR due to insufficient reviews.
- [ ] Protect `staging` and `main` branches
- [ ] Automatically open PR to prod when code is merged to staging
- [ ] Compare auto-merging PR when all checks pass vs merging prior to deployment
