Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD794C9D;
	Fri, 27 Sep 2024 05:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727415561; cv=none; b=Kn9HGKgJy+2+G/RyOW+jQpe6DS09tMYVTGYgPMr7Nz0qeZsFbgYzcBmgIqUqd1E+AwTd9QhMGZQv0Xjoz7nlqVYWffjfSAajPQqgQmU0eYWaPuFy/SQ18wtdDxUSz+96wdsiGr4GncnmEZ22s3e28XcEUJh6jSotWmBAzG9f8l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727415561; c=relaxed/simple;
	bh=JBLatPghxva1l+nLgXXt8leIe/7Ex+r2WJ+pSUyAuds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttHYJJmweVSdQMYDM8x6kz0XK4nuzWp1pt9mFj0SsFeTWNHaDzblqYn4BXSi2QVuHG+4Lp1GZGgItdiJyFRhLXoSevV2JzM4VxYFfIdpfQXjVgeJVWAobgYjV3KObMIr93UgN/VZEXc6IwS4006HVXhBcc1XQspfxT5zWmMswS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUDhVAZT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUDhVAZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3ECC4CEC4;
	Fri, 27 Sep 2024 05:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727415560;
	bh=JBLatPghxva1l+nLgXXt8leIe/7Ex+r2WJ+pSUyAuds=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=EUDhVAZT5kjBcCkhGzQNjc4umvN1KIHl4YX4wlHWrg4vULpWnDP/WHlbMQz6Eeemb
	 l6uJThEbMkLC51LcL4FNCCkbVvcxEJor+evY8K32YP0g8j5l7bxh/KsDlLAQE5RVm/
	 HiSueMT20+xMqrkOrFORuyfJT4chwutsCuc1fcDKzMJIwuPuP+XtG3nDc5xYt2JLWY
	 1jKCCCST4jyEETyjumFC7T9jgwTCLsIFW2L3wnVvoYqhGzTBXtny8PJLlCQsnSUoyG
	 JrW/kwpaoYvPTFn17AT0At5mYPUix0Kmr8w/RJkmdEBaFu5w5DnjBaC9HWBukIFhUo
	 QXaPtkCFFGI5w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 796E3CE1291; Thu, 26 Sep 2024 22:39:19 -0700 (PDT)
Date: Thu, 26 Sep 2024 22:39:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 19/20] treewide: Introduce kthread_run_worker[_on_cpu]()
Message-ID: <a51679d9-0939-4427-9678-b84b49d9102e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240926224910.11106-1-frederic@kernel.org>
 <20240926224910.11106-20-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926224910.11106-20-frederic@kernel.org>

On Fri, Sep 27, 2024 at 12:49:07AM +0200, Frederic Weisbecker wrote:
> kthread_create() creates a kthread without running it yet. kthread_run()
> creates a kthread and runs it.
> 
> On the other hand, kthread_create_worker() creates a kthread worker and
> runs it.
> 
> This difference in behaviours is confusing. Also there is no way to
> create a kthread worker and affine it using kthread_bind_mask() or
> kthread_affine_preferred() before starting it.
> 
> Consolidate the behaviours and introduce kthread_run_worker[_on_cpu]()
> that behaves just like kthread_run(). kthread_create_worker[_on_cpu]()
> will now only create a kthread worker without starting it.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

For the RCU pieces:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  arch/x86/kvm/i8254.c                          |  2 +-
>  crypto/crypto_engine.c                        |  2 +-
>  drivers/cpufreq/cppc_cpufreq.c                |  2 +-
>  drivers/gpu/drm/drm_vblank_work.c             |  2 +-
>  .../drm/i915/gem/selftests/i915_gem_context.c |  2 +-
>  drivers/gpu/drm/i915/gt/selftest_execlists.c  |  2 +-
>  drivers/gpu/drm/i915/gt/selftest_hangcheck.c  |  2 +-
>  drivers/gpu/drm/i915/gt/selftest_slpc.c       |  2 +-
>  drivers/gpu/drm/i915/selftests/i915_request.c |  8 ++--
>  drivers/gpu/drm/msm/disp/msm_disp_snapshot.c  |  2 +-
>  drivers/gpu/drm/msm/msm_atomic.c              |  2 +-
>  drivers/gpu/drm/msm/msm_gpu.c                 |  2 +-
>  drivers/gpu/drm/msm/msm_kms.c                 |  2 +-
>  .../platform/chips-media/wave5/wave5-vpu.c    |  2 +-
>  drivers/net/dsa/mv88e6xxx/chip.c              |  2 +-
>  drivers/net/ethernet/intel/ice/ice_dpll.c     |  2 +-
>  drivers/net/ethernet/intel/ice/ice_gnss.c     |  2 +-
>  drivers/net/ethernet/intel/ice/ice_ptp.c      |  2 +-
>  drivers/platform/chrome/cros_ec_spi.c         |  2 +-
>  drivers/ptp/ptp_clock.c                       |  2 +-
>  drivers/spi/spi.c                             |  2 +-
>  drivers/usb/typec/tcpm/tcpm.c                 |  2 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c              |  2 +-
>  drivers/watchdog/watchdog_dev.c               |  2 +-
>  fs/erofs/zdata.c                              |  2 +-
>  include/linux/kthread.h                       | 48 ++++++++++++++++---
>  kernel/kthread.c                              | 31 +++---------
>  kernel/rcu/tree.c                             |  4 +-
>  kernel/sched/ext.c                            |  2 +-
>  kernel/workqueue.c                            |  2 +-
>  net/dsa/tag_ksz.c                             |  2 +-
>  net/dsa/tag_ocelot_8021q.c                    |  2 +-
>  net/dsa/tag_sja1105.c                         |  2 +-
>  33 files changed, 83 insertions(+), 66 deletions(-)
> 
> diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
> index cd57a517d04a..d7ab8780ab9e 100644
> --- a/arch/x86/kvm/i8254.c
> +++ b/arch/x86/kvm/i8254.c
> @@ -681,7 +681,7 @@ struct kvm_pit *kvm_create_pit(struct kvm *kvm, u32 flags)
>  	pid_nr = pid_vnr(pid);
>  	put_pid(pid);
>  
> -	pit->worker = kthread_create_worker(0, "kvm-pit/%d", pid_nr);
> +	pit->worker = kthread_run_worker(0, "kvm-pit/%d", pid_nr);
>  	if (IS_ERR(pit->worker))
>  		goto fail_kthread;
>  
> diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
> index e60a0eb628e8..c7c16da5e649 100644
> --- a/crypto/crypto_engine.c
> +++ b/crypto/crypto_engine.c
> @@ -517,7 +517,7 @@ struct crypto_engine *crypto_engine_alloc_init_and_set(struct device *dev,
>  	crypto_init_queue(&engine->queue, qlen);
>  	spin_lock_init(&engine->queue_lock);
>  
> -	engine->kworker = kthread_create_worker(0, "%s", engine->name);
> +	engine->kworker = kthread_run_worker(0, "%s", engine->name);
>  	if (IS_ERR(engine->kworker)) {
>  		dev_err(dev, "failed to create crypto request pump task\n");
>  		return NULL;
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 1a5ad184d28f..9b91cba133c9 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -241,7 +241,7 @@ static void __init cppc_freq_invariance_init(void)
>  	if (fie_disabled)
>  		return;
>  
> -	kworker_fie = kthread_create_worker(0, "cppc_fie");
> +	kworker_fie = kthread_run_worker(0, "cppc_fie");
>  	if (IS_ERR(kworker_fie)) {
>  		pr_warn("%s: failed to create kworker_fie: %ld\n", __func__,
>  			PTR_ERR(kworker_fie));
> diff --git a/drivers/gpu/drm/drm_vblank_work.c b/drivers/gpu/drm/drm_vblank_work.c
> index 1752ffb44e1d..9cc71120246f 100644
> --- a/drivers/gpu/drm/drm_vblank_work.c
> +++ b/drivers/gpu/drm/drm_vblank_work.c
> @@ -277,7 +277,7 @@ int drm_vblank_worker_init(struct drm_vblank_crtc *vblank)
>  
>  	INIT_LIST_HEAD(&vblank->pending_work);
>  	init_waitqueue_head(&vblank->work_wait_queue);
> -	worker = kthread_create_worker(0, "card%d-crtc%d",
> +	worker = kthread_run_worker(0, "card%d-crtc%d",
>  				       vblank->dev->primary->index,
>  				       vblank->pipe);
>  	if (IS_ERR(worker))
> diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
> index 89d4dc8b60c6..eb0158e43417 100644
> --- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
> +++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
> @@ -369,7 +369,7 @@ static int live_parallel_switch(void *arg)
>  		if (!data[n].ce[0])
>  			continue;
>  
> -		worker = kthread_create_worker(0, "igt/parallel:%s",
> +		worker = kthread_run_worker(0, "igt/parallel:%s",
>  					       data[n].ce[0]->engine->name);
>  		if (IS_ERR(worker)) {
>  			err = PTR_ERR(worker);
> diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i915/gt/selftest_execlists.c
> index 222ca7c44951..81c31396eceb 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
> @@ -3574,7 +3574,7 @@ static int smoke_crescendo(struct preempt_smoke *smoke, unsigned int flags)
>  			arg[id].batch = NULL;
>  		arg[id].count = 0;
>  
> -		worker[id] = kthread_create_worker(0, "igt/smoke:%d", id);
> +		worker[id] = kthread_run_worker(0, "igt/smoke:%d", id);
>  		if (IS_ERR(worker[id])) {
>  			err = PTR_ERR(worker[id]);
>  			break;
> diff --git a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
> index 9ce8ff1c04fe..9d3aeb237295 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
> @@ -1025,7 +1025,7 @@ static int __igt_reset_engines(struct intel_gt *gt,
>  			threads[tmp].engine = other;
>  			threads[tmp].flags = flags;
>  
> -			worker = kthread_create_worker(0, "igt/%s",
> +			worker = kthread_run_worker(0, "igt/%s",
>  						       other->name);
>  			if (IS_ERR(worker)) {
>  				err = PTR_ERR(worker);
> diff --git a/drivers/gpu/drm/i915/gt/selftest_slpc.c b/drivers/gpu/drm/i915/gt/selftest_slpc.c
> index 4ecc4ae74a54..e218b229681f 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_slpc.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_slpc.c
> @@ -489,7 +489,7 @@ static int live_slpc_tile_interaction(void *arg)
>  		return -ENOMEM;
>  
>  	for_each_gt(gt, i915, i) {
> -		threads[i].worker = kthread_create_worker(0, "igt/slpc_parallel:%d", gt->info.id);
> +		threads[i].worker = kthread_run_worker(0, "igt/slpc_parallel:%d", gt->info.id);
>  
>  		if (IS_ERR(threads[i].worker)) {
>  			ret = PTR_ERR(threads[i].worker);
> diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
> index acae30a04a94..88870844b5bd 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_request.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_request.c
> @@ -492,7 +492,7 @@ static int mock_breadcrumbs_smoketest(void *arg)
>  	for (n = 0; n < ncpus; n++) {
>  		struct kthread_worker *worker;
>  
> -		worker = kthread_create_worker(0, "igt/%d", n);
> +		worker = kthread_run_worker(0, "igt/%d", n);
>  		if (IS_ERR(worker)) {
>  			ret = PTR_ERR(worker);
>  			ncpus = n;
> @@ -1645,7 +1645,7 @@ static int live_parallel_engines(void *arg)
>  		for_each_uabi_engine(engine, i915) {
>  			struct kthread_worker *worker;
>  
> -			worker = kthread_create_worker(0, "igt/parallel:%s",
> +			worker = kthread_run_worker(0, "igt/parallel:%s",
>  						       engine->name);
>  			if (IS_ERR(worker)) {
>  				err = PTR_ERR(worker);
> @@ -1806,7 +1806,7 @@ static int live_breadcrumbs_smoketest(void *arg)
>  			unsigned int i = idx * ncpus + n;
>  			struct kthread_worker *worker;
>  
> -			worker = kthread_create_worker(0, "igt/%d.%d", idx, n);
> +			worker = kthread_run_worker(0, "igt/%d.%d", idx, n);
>  			if (IS_ERR(worker)) {
>  				ret = PTR_ERR(worker);
>  				goto out_flush;
> @@ -3219,7 +3219,7 @@ static int perf_parallel_engines(void *arg)
>  
>  			memset(&engines[idx].p, 0, sizeof(engines[idx].p));
>  
> -			worker = kthread_create_worker(0, "igt:%s",
> +			worker = kthread_run_worker(0, "igt:%s",
>  						       engine->name);
>  			if (IS_ERR(worker)) {
>  				err = PTR_ERR(worker);
> diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
> index e75b97127c0d..2be00b11e557 100644
> --- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
> +++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
> @@ -109,7 +109,7 @@ int msm_disp_snapshot_init(struct drm_device *drm_dev)
>  
>  	mutex_init(&kms->dump_mutex);
>  
> -	kms->dump_worker = kthread_create_worker(0, "%s", "disp_snapshot");
> +	kms->dump_worker = kthread_run_worker(0, "%s", "disp_snapshot");
>  	if (IS_ERR(kms->dump_worker))
>  		DRM_ERROR("failed to create disp state task\n");
>  
> diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
> index 9c45d641b521..a7a2384044ff 100644
> --- a/drivers/gpu/drm/msm/msm_atomic.c
> +++ b/drivers/gpu/drm/msm/msm_atomic.c
> @@ -115,7 +115,7 @@ int msm_atomic_init_pending_timer(struct msm_pending_timer *timer,
>  	timer->kms = kms;
>  	timer->crtc_idx = crtc_idx;
>  
> -	timer->worker = kthread_create_worker(0, "atomic-worker-%d", crtc_idx);
> +	timer->worker = kthread_run_worker(0, "atomic-worker-%d", crtc_idx);
>  	if (IS_ERR(timer->worker)) {
>  		int ret = PTR_ERR(timer->worker);
>  		timer->worker = NULL;
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index a274b8466423..15f74e9dfc9e 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -859,7 +859,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>  	gpu->funcs = funcs;
>  	gpu->name = name;
>  
> -	gpu->worker = kthread_create_worker(0, "gpu-worker");
> +	gpu->worker = kthread_run_worker(0, "gpu-worker");
>  	if (IS_ERR(gpu->worker)) {
>  		ret = PTR_ERR(gpu->worker);
>  		gpu->worker = NULL;
> diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
> index af6a6fcb1173..8db9f3afb8ac 100644
> --- a/drivers/gpu/drm/msm/msm_kms.c
> +++ b/drivers/gpu/drm/msm/msm_kms.c
> @@ -269,7 +269,7 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
>  		/* initialize event thread */
>  		ev_thread = &priv->event_thread[drm_crtc_index(crtc)];
>  		ev_thread->dev = ddev;
> -		ev_thread->worker = kthread_create_worker(0, "crtc_event:%d", crtc->base.id);
> +		ev_thread->worker = kthread_run_worker(0, "crtc_event:%d", crtc->base.id);
>  		if (IS_ERR(ev_thread->worker)) {
>  			ret = PTR_ERR(ev_thread->worker);
>  			DRM_DEV_ERROR(dev, "failed to create crtc_event kthread\n");
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> index 7273254ecb03..c49f5ed461cf 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> @@ -231,7 +231,7 @@ static int wave5_vpu_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "failed to get irq resource, falling back to polling\n");
>  		hrtimer_init(&dev->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
>  		dev->hrtimer.function = &wave5_vpu_timer_callback;
> -		dev->worker = kthread_create_worker(0, "vpu_irq_thread");
> +		dev->worker = kthread_run_worker(0, "vpu_irq_thread");
>  		if (IS_ERR(dev->worker)) {
>  			dev_err(&pdev->dev, "failed to create vpu irq worker\n");
>  			ret = PTR_ERR(dev->worker);
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 5b4e2ce5470d..a5908e2ff2cf 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -393,7 +393,7 @@ static int mv88e6xxx_irq_poll_setup(struct mv88e6xxx_chip *chip)
>  	kthread_init_delayed_work(&chip->irq_poll_work,
>  				  mv88e6xxx_irq_poll);
>  
> -	chip->kworker = kthread_create_worker(0, "%s", dev_name(chip->dev));
> +	chip->kworker = kthread_run_worker(0, "%s", dev_name(chip->dev));
>  	if (IS_ERR(chip->kworker))
>  		return PTR_ERR(chip->kworker);
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index cd95705d1e7f..1f11a24387f3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -2050,7 +2050,7 @@ static int ice_dpll_init_worker(struct ice_pf *pf)
>  	struct kthread_worker *kworker;
>  
>  	kthread_init_delayed_work(&d->work, ice_dpll_periodic_work);
> -	kworker = kthread_create_worker(0, "ice-dplls-%s",
> +	kworker = kthread_run_worker(0, "ice-dplls-%s",
>  					dev_name(ice_pf_to_dev(pf)));
>  	if (IS_ERR(kworker))
>  		return PTR_ERR(kworker);
> diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
> index c8ea1af51ad3..fcd1f808b696 100644
> --- a/drivers/net/ethernet/intel/ice/ice_gnss.c
> +++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
> @@ -182,7 +182,7 @@ static struct gnss_serial *ice_gnss_struct_init(struct ice_pf *pf)
>  	pf->gnss_serial = gnss;
>  
>  	kthread_init_delayed_work(&gnss->read_work, ice_gnss_read);
> -	kworker = kthread_create_worker(0, "ice-gnss-%s", dev_name(dev));
> +	kworker = kthread_run_worker(0, "ice-gnss-%s", dev_name(dev));
>  	if (IS_ERR(kworker)) {
>  		kfree(gnss);
>  		return NULL;
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index ef2e858f49bb..cd7da48bdf91 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -3185,7 +3185,7 @@ static int ice_ptp_init_work(struct ice_pf *pf, struct ice_ptp *ptp)
>  	/* Allocate a kworker for handling work required for the ports
>  	 * connected to the PTP hardware clock.
>  	 */
> -	kworker = kthread_create_worker(0, "ice-ptp-%s",
> +	kworker = kthread_run_worker(0, "ice-ptp-%s",
>  					dev_name(ice_pf_to_dev(pf)));
>  	if (IS_ERR(kworker))
>  		return PTR_ERR(kworker);
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> index 86a3d32a7763..08f566cc1480 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -715,7 +715,7 @@ static int cros_ec_spi_devm_high_pri_alloc(struct device *dev,
>  	int err;
>  
>  	ec_spi->high_pri_worker =
> -		kthread_create_worker(0, "cros_ec_spi_high_pri");
> +		kthread_run_worker(0, "cros_ec_spi_high_pri");
>  
>  	if (IS_ERR(ec_spi->high_pri_worker)) {
>  		err = PTR_ERR(ec_spi->high_pri_worker);
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index c56cd0f63909..89a4420972e7 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -295,7 +295,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  
>  	if (ptp->info->do_aux_work) {
>  		kthread_init_delayed_work(&ptp->aux_work, ptp_aux_kworker);
> -		ptp->kworker = kthread_create_worker(0, "ptp%d", ptp->index);
> +		ptp->kworker = kthread_run_worker(0, "ptp%d", ptp->index);
>  		if (IS_ERR(ptp->kworker)) {
>  			err = PTR_ERR(ptp->kworker);
>  			pr_err("failed to create ptp aux_worker %d\n", err);
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index c1dad30a4528..f2f4b6ee25d4 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2053,7 +2053,7 @@ static int spi_init_queue(struct spi_controller *ctlr)
>  	ctlr->busy = false;
>  	ctlr->queue_empty = true;
>  
> -	ctlr->kworker = kthread_create_worker(0, dev_name(&ctlr->dev));
> +	ctlr->kworker = kthread_run_worker(0, dev_name(&ctlr->dev));
>  	if (IS_ERR(ctlr->kworker)) {
>  		dev_err(&ctlr->dev, "failed to create message pump kworker\n");
>  		return PTR_ERR(ctlr->kworker);
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index fc619478200f..66ae934ad196 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -7577,7 +7577,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	mutex_init(&port->lock);
>  	mutex_init(&port->swap_lock);
>  
> -	port->wq = kthread_create_worker(0, dev_name(dev));
> +	port->wq = kthread_run_worker(0, dev_name(dev));
>  	if (IS_ERR(port->wq))
>  		return ERR_CAST(port->wq);
>  	sched_set_fifo(port->wq->task);
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 8ffea8430f95..c204fc8e471a 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -229,7 +229,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
>  	dev = &vdpasim->vdpa.dev;
>  
>  	kthread_init_work(&vdpasim->work, vdpasim_work_fn);
> -	vdpasim->worker = kthread_create_worker(0, "vDPA sim worker: %s",
> +	vdpasim->worker = kthread_run_worker(0, "vDPA sim worker: %s",
>  						dev_attr->name);
>  	if (IS_ERR(vdpasim->worker))
>  		goto err_iommu;
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 4190cb800cc4..19698d87dc57 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -1229,7 +1229,7 @@ int __init watchdog_dev_init(void)
>  {
>  	int err;
>  
> -	watchdog_kworker = kthread_create_worker(0, "watchdogd");
> +	watchdog_kworker = kthread_run_worker(0, "watchdogd");
>  	if (IS_ERR(watchdog_kworker)) {
>  		pr_err("Failed to create watchdog kworker\n");
>  		return PTR_ERR(watchdog_kworker);
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 050aaa016ec8..bf6b4d8cb283 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -318,7 +318,7 @@ static void erofs_destroy_percpu_workers(void)
>  static struct kthread_worker *erofs_init_percpu_worker(int cpu)
>  {
>  	struct kthread_worker *worker =
> -		kthread_create_worker_on_cpu(cpu, 0, "erofs_worker/%u");
> +		kthread_run_worker_on_cpu(cpu, 0, "erofs_worker/%u");
>  
>  	if (IS_ERR(worker))
>  		return worker;
> diff --git a/include/linux/kthread.h b/include/linux/kthread.h
> index 0c66e7c1092a..8d27403888ce 100644
> --- a/include/linux/kthread.h
> +++ b/include/linux/kthread.h
> @@ -193,19 +193,53 @@ struct kthread_worker *kthread_create_worker_on_node(unsigned int flags,
>  						     const char namefmt[], ...);
>  
>  #define kthread_create_worker(flags, namefmt, ...) \
> -({									   \
> -	struct kthread_worker *__kw					   \
> -		= kthread_create_worker_on_node(flags, NUMA_NO_NODE,	   \
> -						namefmt, ## __VA_ARGS__);  \
> -	if (!IS_ERR(__kw))						   \
> -		wake_up_process(__kw->task);				   \
> -	__kw;								   \
> +	kthread_create_worker_on_node(flags, NUMA_NO_NODE, namefmt, ## __VA_ARGS__);
> +
> +/**
> + * kthread_run_worker - create and wake a kthread worker.
> + * @flags: flags modifying the default behavior of the worker
> + * @namefmt: printf-style name for the thread.
> + *
> + * Description: Convenient wrapper for kthread_create_worker() followed by
> + * wake_up_process().  Returns the kthread_worker or ERR_PTR(-ENOMEM).
> + */
> +#define kthread_run_worker(flags, namefmt, ...)					\
> +({										\
> +	struct kthread_worker *__kw						\
> +		= kthread_create_worker(flags, namefmt, ## __VA_ARGS__);	\
> +	if (!IS_ERR(__kw))							\
> +		wake_up_process(__kw->task);					\
> +	__kw;									\
>  })
>  
>  struct kthread_worker *
>  kthread_create_worker_on_cpu(int cpu, unsigned int flags,
>  			     const char namefmt[]);
>  
> +/**
> + * kthread_run_worker_on_cpu - create and wake a cpu bound kthread worker.
> + * @cpu: CPU number
> + * @flags: flags modifying the default behavior of the worker
> + * @namefmt: printf-style name for the thread. Format is restricted
> + *	     to "name.*%u". Code fills in cpu number.
> + *
> + * Description: Convenient wrapper for kthread_create_worker_on_cpu()
> + * followed by wake_up_process().  Returns the kthread_worker or
> + * ERR_PTR(-ENOMEM).
> + */
> +static inline struct kthread_worker *
> +kthread_run_worker_on_cpu(int cpu, unsigned int flags,
> +			  const char namefmt[])
> +{
> +	struct kthread_worker *kw;
> +
> +	kw = kthread_create_worker_on_cpu(cpu, flags, namefmt);
> +	if (!IS_ERR(kw))
> +		wake_up_process(kw->task);
> +
> +	return kw;
> +}
> +
>  bool kthread_queue_work(struct kthread_worker *worker,
>  			struct kthread_work *work);
>  
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 7eb93c248c59..d9fee08e9a66 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -1075,33 +1075,10 @@ kthread_create_worker_on_node(unsigned int flags, int node, const char namefmt[]
>  	worker = __kthread_create_worker_on_node(flags, node, namefmt, args);
>  	va_end(args);
>  
> -	if (worker)
> -		wake_up_process(worker->task);
> -
>  	return worker;
>  }
>  EXPORT_SYMBOL(kthread_create_worker_on_node);
>  
> -static __printf(3, 4) struct kthread_worker *
> -__kthread_create_worker_on_cpu(int cpu, unsigned int flags,
> -			       const char namefmt[], ...)
> -{
> -	struct kthread_worker *worker;
> -	va_list args;
> -
> -	va_start(args, namefmt);
> -	worker = __kthread_create_worker_on_node(flags, cpu_to_node(cpu),
> -						 namefmt, args);
> -	va_end(args);
> -
> -	if (worker) {
> -		kthread_bind(worker->task, cpu);
> -		wake_up_process(worker->task);
> -	}
> -
> -	return worker;
> -}
> -
>  /**
>   * kthread_create_worker_on_cpu - create a kthread worker and bind it
>   *	to a given CPU and the associated NUMA node.
> @@ -1142,7 +1119,13 @@ struct kthread_worker *
>  kthread_create_worker_on_cpu(int cpu, unsigned int flags,
>  			     const char namefmt[])
>  {
> -	return __kthread_create_worker_on_cpu(cpu, flags, namefmt, cpu);
> +	struct kthread_worker *worker;
> +
> +	worker = kthread_create_worker_on_node(flags, cpu_to_node(cpu), namefmt, cpu);
> +	if (worker)
> +		kthread_bind(worker->task, cpu);
> +
> +	return worker;
>  }
>  EXPORT_SYMBOL(kthread_create_worker_on_cpu);
>  
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c1e9f0818d51..a44228b0949a 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4902,7 +4902,7 @@ static void rcu_spawn_exp_par_gp_kworker(struct rcu_node *rnp)
>  	if (rnp->exp_kworker)
>  		return;
>  
> -	kworker = kthread_create_worker(0, name, rnp_index);
> +	kworker = kthread_run_worker(0, name, rnp_index);
>  	if (IS_ERR_OR_NULL(kworker)) {
>  		pr_err("Failed to create par gp kworker on %d/%d\n",
>  		       rnp->grplo, rnp->grphi);
> @@ -4929,7 +4929,7 @@ static void __init rcu_start_exp_gp_kworker(void)
>  	const char *name = "rcu_exp_gp_kthread_worker";
>  	struct sched_param param = { .sched_priority = kthread_prio };
>  
> -	rcu_exp_gp_kworker = kthread_create_worker(0, name);
> +	rcu_exp_gp_kworker = kthread_run_worker(0, name);
>  	if (IS_ERR_OR_NULL(rcu_exp_gp_kworker)) {
>  		pr_err("Failed to create %s!\n", name);
>  		rcu_exp_gp_kworker = NULL;
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index c09e3dc38c34..4835fa4d9326 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4885,7 +4885,7 @@ static struct kthread_worker *scx_create_rt_helper(const char *name)
>  {
>  	struct kthread_worker *helper;
>  
> -	helper = kthread_create_worker(0, name);
> +	helper = kthread_run_worker(0, name);
>  	if (helper)
>  		sched_set_fifo(helper->task);
>  	return helper;
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 9949ffad8df0..f5c7447ae1de 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -7814,7 +7814,7 @@ static void __init wq_cpu_intensive_thresh_init(void)
>  	unsigned long thresh;
>  	unsigned long bogo;
>  
> -	pwq_release_worker = kthread_create_worker(0, "pool_workqueue_release");
> +	pwq_release_worker = kthread_run_worker(0, "pool_workqueue_release");
>  	BUG_ON(IS_ERR(pwq_release_worker));
>  
>  	/* if the user set it to a specific value, keep it */
> diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
> index 281bbac5539d..c33d4bf17929 100644
> --- a/net/dsa/tag_ksz.c
> +++ b/net/dsa/tag_ksz.c
> @@ -66,7 +66,7 @@ static int ksz_connect(struct dsa_switch *ds)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	xmit_worker = kthread_create_worker(0, "dsa%d:%d_xmit",
> +	xmit_worker = kthread_run_worker(0, "dsa%d:%d_xmit",
>  					    ds->dst->index, ds->index);
>  	if (IS_ERR(xmit_worker)) {
>  		ret = PTR_ERR(xmit_worker);
> diff --git a/net/dsa/tag_ocelot_8021q.c b/net/dsa/tag_ocelot_8021q.c
> index 8e8b1bef6af6..6ce0bc166792 100644
> --- a/net/dsa/tag_ocelot_8021q.c
> +++ b/net/dsa/tag_ocelot_8021q.c
> @@ -110,7 +110,7 @@ static int ocelot_connect(struct dsa_switch *ds)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	priv->xmit_worker = kthread_create_worker(0, "felix_xmit");
> +	priv->xmit_worker = kthread_run_worker(0, "felix_xmit");
>  	if (IS_ERR(priv->xmit_worker)) {
>  		err = PTR_ERR(priv->xmit_worker);
>  		kfree(priv);
> diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
> index 3e902af7eea6..02adec693811 100644
> --- a/net/dsa/tag_sja1105.c
> +++ b/net/dsa/tag_sja1105.c
> @@ -707,7 +707,7 @@ static int sja1105_connect(struct dsa_switch *ds)
>  
>  	spin_lock_init(&priv->meta_lock);
>  
> -	xmit_worker = kthread_create_worker(0, "dsa%d:%d_xmit",
> +	xmit_worker = kthread_run_worker(0, "dsa%d:%d_xmit",
>  					    ds->dst->index, ds->index);
>  	if (IS_ERR(xmit_worker)) {
>  		err = PTR_ERR(xmit_worker);
> -- 
> 2.46.0
> 
