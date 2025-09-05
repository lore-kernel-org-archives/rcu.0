Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292B2284689
	for <rcu@vger.kernel.org>; Fri,  5 Sep 2025 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063284; cv=none; b=N3Kth3lOb2NmWAcWhi4ydI/WtIVg8jgT99xV1+DRpwnfumNUYlcBUYjqT+sqGbKDFUKxBm/VRC0PX8KxkJhiMt6nWdECER3Hgiv8HRsvfmyktTdqLvLBQy5vIc2HokFX4hNlapI8UlefdgRKV+q89U7Ak1upwwCnlN+Inot6PI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063284; c=relaxed/simple;
	bh=iFOnnxJrC94LV2LEks6kE1pmEF2x261VyN5f5eLmpgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CJY7w+8vx2enVhoo8IzS4trrr8C+BbNvOSg9f7FA1valJSJyKLRdhs5imZ/Ld2VXNBkRct8Z0OQImNEROU2Ca/ieV6GFzORdvqynD8LXF/ZQb0mexhxIC8ezSCYtCK3IOVus1tIVQRLJ52/gxpWpp2yF964aPy/S9QarliJKwq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CsktbZDU; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CsktbZDU"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3e4aeaa57b9so137991f8f.1
        for <rcu@vger.kernel.org>; Fri, 05 Sep 2025 02:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063280; x=1757668080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RMG28cPmINkh9yGK/HjokSpuEVCf8KpRl5KQ/ClSDEs=;
        b=CsktbZDUMLrmFf/KMdU6w0W6C5v7TPUsSEp5al2zyFDMWu9awaduoFqjRnx0N3lGI+
         XRzS1Tj4JZcB4yiSV6ubZMOJUmXmFzEtyyN2sILapCM42dg4oPTlBSz2ru+1qaBmAW+W
         wY6lCIyRa5PwvFv7q5n3nx39QwatebPcOjkwTaQ48+gxJKLRkw8mLnMTYQQopyF3/5n4
         8q0J8EL0hfrHb5bARyigpyXe6ajCIf5uiz8tIdHgRaDfohrKEvbjBSiAGRzB9rvKZQvN
         zHsjiVKx3tPCDBTQu4h2aDryvr/9vGHcJx0zYW+oiTddSB1y4V36wh68DqYYLB+zkL7N
         rPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063280; x=1757668080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMG28cPmINkh9yGK/HjokSpuEVCf8KpRl5KQ/ClSDEs=;
        b=vIueupobLcP3oNY3inMVFcycEx5XApH79O+rXRdZCnpUgbsEZCDIONZRoToD3c3Nf/
         08Mt+jFF+XZ+V/LL3o+MmsgHFpjadcxSBe8+MP+FobUB2hlx9Dk9G0SaOSz1jmEnfx6r
         q0UnAmeBzQMQb/ldSm6G3PuhwnKOEMhSVuVQn9Pej7fuCaNoxfPKGJJhdzEaT8LXOBMq
         hlP4nZLhvm8zHcQ66BXwJQJgZvWUT7rf8OLQvLJB1PNAGUjs/40S+oE/hxc4yu0H1Rtt
         QZZ9Xy69cuTKwykueqmhGFpBQ9VcogHDDUwWBG3R/lXA56jlzKeL1E0zlyjEEkHM0IiH
         eleQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvvyA8A3GJKo1wV5NN9mNbOt9/jEB98cGCvHoTLK8t8K2N9TrGixqz6JI7MDSDy1aF+rw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5kF2xo/Ldy05oRdtkQ+jvDffFE+mv7YtGWdULwy1Pzg91E/L7
	k7/dWoV1oVJh5mFFqXesAZ4bGV8ydXXTK1l3Xh5D7bSA+i2dcjntd2ho4lQxwSKyv14=
X-Gm-Gg: ASbGncuPovELitbiFucTW54ZA7DnyQOrTnKNllE4J/kyRcta/thDGcZB1HX8rjhhxLC
	I315ClZ+VIdmyrhAGeF9eQUhAzB6/3or9BVqMmirfugu7Pf8jEQOSdmzH4qhNXKBg6WvNFthRJu
	jPqekgji7/fF+Y63aNSp+kSYX/jXQPWuzhAkzmwrGGH6sfz8zxGY/rEUX8GeEjP4pvB8kOqxoKg
	N6jqok+eieeZ/4gbUiDAHytTY38Hnw2FHARoA3vD78ac0glyEitNgt2YFlmfiIz+7LpGQ0I+7mw
	+0qcKaMF/r+HkFj0J5NpmHN5eS0c6pH6oDfOrLVT1FthSbBBvQnqgWeHX1gj//PtR2DrdGLMUc6
	mjxVWx6UTa7YB+TFEqievzBn1XZYJ8OJwksbmn/FMbAadZlzdMT8/gt6VEw==
X-Google-Smtp-Source: AGHT+IHXqencWzdhmJCLzSHG6b957AFApxs+PiiNiGv952XmmQ7dyv023BmoBwStfcQ3i9qpXNojQw==
X-Received: by 2002:a05:6000:200f:b0:3d5:d5ea:38d5 with SMTP id ffacd0b85a97d-3d5d5ea4100mr18390890f8f.25.1757063280428;
        Fri, 05 Sep 2025 02:08:00 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7fec07sm311505335e9.10.2025.09.05.02.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:08:00 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH 0/2] rcu: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 11:07:45 +0200
Message-ID: <20250905090747.107232-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!

Below is a summary of a discussion about the Workqueue API and cpu isolation
considerations. Details and more information are available here:

        "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
        https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an isolated
CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

=== Plan and future plans ===

This patchset is the first stone on a refactoring needed in order to
address the points aforementioned; it will have a positive impact also
on the cpu isolation, in the long term, moving away percpu workqueue in
favor to an unbound model.

These are the main steps:
1)  API refactoring (that this patch is introducing)
    -   Make more clear and uniform the system wq names, both per-cpu and
        unbound. This to avoid any possible confusion on what should be
        used.

    -   Introduction of WQ_PERCPU: this flag is the complement of WQ_UNBOUND,
        introduced in this patchset and used on all the callers that are not
        currently using WQ_UNBOUND.

        WQ_UNBOUND will be removed in a future release cycle.

        Most users don't need to be per-cpu, because they don't have
        locality requirements, because of that, a next future step will be
        make "unbound" the default behavior.

2)  Check who really needs to be per-cpu
    -   Remove the WQ_PERCPU flag when is not strictly required.

3)  Add a new API (prefer local cpu)
    -   There are users that don't require a local execution, like mentioned
        above; despite that, local execution yeld to performance gain.

        This new API will prefer the local execution, without requiring it.

=== Introduced Changes by this series ===

1) [P 1] Replace use of system_wq

        system_wq is a per-CPU workqueue, but his name is not clear.

        Because of that, system_wq has been renamed in system_percpu_wq..

2) [P 2] add WQ_PERCPU to remaining alloc_workqueue() users

        Every alloc_workqueue() caller should use one among WQ_PERCPU or
        WQ_UNBOUND. This is actually enforced warning if both or none of them
        are present at the same time.

        WQ_UNBOUND will be removed in a next release cycle.

=== For Maintainers ===

There are prerequisites for this series, already merged in the master branch.
The commits are:

128ea9f6ccfb6960293ae4212f4f97165e42222d ("workqueue: Add system_percpu_wq and
system_dfl_wq")

930c2ea566aff59e962c50b2421d5fcc3b98b8be ("workqueue: Add new WQ_PERCPU flag")


Thanks!

Marco Crivellari (2):
  rcu: replace use of system_wq with system_percpu_wq
  rcu: WQ_PERCPU added to alloc_workqueue users

 kernel/rcu/tasks.h | 4 ++--
 kernel/rcu/tree.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.51.0

