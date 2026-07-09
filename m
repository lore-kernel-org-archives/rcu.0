Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1141C3655C9
	for <rcu@vger.kernel.org>; Thu,  9 Jul 2026 02:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564350; cv=none; b=eoC7MqOzepyky/qRDISlFn8+r27ZJ/GmYhOb7snIfj6IWmSSJtsettmkBMPpzZusnIjTiyQI3MCI43yjgYNJvxQdLHVEbvxNv589ANECii0Psduy1A1fGLpQiE++IwWd9vg30M9ZP7xKvQYbOvlVuSHzusBa4znkK0X4BZa6f3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564350; c=relaxed/simple;
	bh=lkIEGCAQB9zasZeDMyaogtJAsY/y74T/tGmONLBNQ14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkYXREFfv/bMOap7U7YBlwe9m0kmdrub4ocPJuCrQ4ZRszfER8rpydy6hrpruAAD5NY6a5WkdTJ1Sg0EftCCn7upOR0u4/CyPfviGwwxkXnzVOfm71C2Z00YjywwLjm9MsSdiaim5KDI+p7iM0hYzNKBQCdw4VBwj3HxoSLJIJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKqSMIYA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKqSMIYA"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ccf2360620so10668015ad.3
        for <rcu@vger.kernel.org>; Wed, 08 Jul 2026 19:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783564348; x=1784169148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+15WoPo9JZ7YZJgmoBicVekPX6+Bo4zcfrfvSoymnE=;
        b=gKqSMIYAP5yxJmdOdbX1yuJ/esOPdQaIyPO0GgiCbfxFp6pFAwo8em7XViI2UNrBr+
         3N5Cnw0XS2qyX6ie9EEcb1vbf2Kw4cU/5CFA9151mrw6AwZ9gn67nBEUyeVOjaBqhj8u
         9WSQoDW4/REadcOP3OGYyH9eThTb4AxGtmZ5QF4gw16pxVUZlD6jiPg93ZYQ9R8ZTsga
         kGaNXKCdVpzGWywzR/wgGmLFo1TasyslIgyt9puSzfs1IZlXECuMHp2ZDenr0XVtVtIh
         SAEKsIc9W/TQexG3dp5GfExtzwVvvSf4ocJPWxr2qhnlCO/3TE8bNQXRR+ICYlkSI+Lc
         fang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783564348; x=1784169148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q+15WoPo9JZ7YZJgmoBicVekPX6+Bo4zcfrfvSoymnE=;
        b=UiGIQrKx1pdOJS3/rPxqsDQKHbSKK0Tl5xp72/H7kQNDXai4vOKZywpW1Ws+br95PI
         97ncXUIi8vK5jBVaJT6J+KkSNjIon9u0IA1xbb6MOizigUJltpkv4NauW+mTZ53+72bG
         puUEX6LX8e0Q0Lkx7ycvCteEMMnJfWylL3KdHnn15IWNmd8P9QEOuBUFOQA31ugCAxti
         HtDo8+c2mtGlh8ywOrW8k+ZzBqz84qZ5Ia3aMp3p7UzsivoLeX2m0VneLjZrwxVrtXsk
         3t8axrRjV2ixprNIcVbUyml7EZdH3zpUoMgsM/l+KYkspMr+5a8DSRRDvRdeVenH4hFU
         zgJQ==
X-Forwarded-Encrypted: i=1; AHgh+RqzQcoDX7R8R9u86Lpr+mw9UnX/oYAJfowKbQkcFoOGiRglyiIDr2fWA/Vo0Hzwr8Bmgeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyok8Nw6tqxhwEbxj9RnbJ5J8k/g4Bc2BEElo340YmHPgXAidSe
	6Tq55SnexBPo4nm7hcNLAgSKyfKJfsNcDeqM/WSfvtVfKSy5+5KffdIc
X-Gm-Gg: AfdE7clsfxRU6K8IEVx87qiLJq8/FG4PLoQ+koiF/XnZHtZm+fMKuOGDsuHbwrYdKAZ
	crf3mVX3MseojSS5u6P/udwOc2bRW7BOMZ1iIAoXlKBJwwtVMVNBwYIBR4dT8vYuZeTeXoSfzZZ
	luHe3y2MZmxC//ZnKpzUQaBQXWsovmfW/fHdUdDvDq+OeGsVTUjbwh3X4LJWvZbKGwEpBXtfPbJ
	4wb0xin4jTcNbm6roKKpAghmdK8CZ2BhDR68n30yiJTbrtFibWah67UHrIx9vTNp8WGt99oCIGx
	mrDqTBoPVjI5HtK3t9lltAbb7i56hseYHDEaiy8ioBb/9ocovjSbLsmNI8Dh9dNEMcDSZVXAuOS
	FaOLddlui+3lNLY/W9LP75HBC6WfWqSM2LvLp+lnv9mS7vNxbkxqzFklOX7BHIvQ0aXi1B17rV+
	X6Xxm7kLg=
X-Received: by 2002:a17:903:298f:b0:2c0:b6c7:227e with SMTP id d9443c01a7336-2ccea3485b7mr64177845ad.5.1783564348234;
        Wed, 08 Jul 2026 19:32:28 -0700 (PDT)
Received: from ubuntu.. ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bde9sm35795005ad.79.2026.07.08.19.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 19:32:27 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: Frederic Weisbecker <frederic@kernel.org>,
	Waiman Long <longman@redhat.com>
Cc: Jing Wu <realwujing@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH-next 00/23] cgroup/cpuset: Enable runtime update of nohz_full and managed_irq CPUs
Date: Thu,  9 Jul 2026 10:32:20 +0800
Message-ID: <20260709023221.634684-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702033934.984512-1-realwujing@gmail.com>
References: <20260421030351.281436-1-longman@redhat.com> <akUii2CyEi7SRid7@localhost.localdomain> <fe35dd41-7068-4cf0-9ee9-eb9c12017b42@redhat.com> <20260702033934.984512-1-realwujing@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we offered to take the RCU/nocb piece, here is a concrete shape to
shoot at.

Constraint recap (kernel/rcu/tree_nocb.h): rcu_nocb_cpu_{offload,deoffload}()
require the CPU offline (they reject when cpu_online()) under cpus_read_lock +
nocb_mutex, and per Frederic the toggle really needs CPUHP_AP_IDLE_DEAD because
callbacks can still be enqueued before that.  Reaching IDLE_DEAD pays the
stop_machine cost that disturbs other isolated partitions.

Observation: among the kernel-noise types, only RCU needs that deep offline;
tick, managed_irq and the watchdog reconfigure through the existing online-side
callbacks.  So bundling RCU under HK_TYPE_KERNEL_NOISE makes every isolation
change pay the RCU cost.

Proposal:

  1. Split HK_TYPE_RCU out of HK_TYPE_KERNEL_NOISE into its own
     runtime-mutable type, plus an immutable HK_TYPE_RCU_BOOT snapshot.
     HK_TYPE_KERNEL_NOISE keeps tick/timer/misc/wq.

  2. Gate nocb changes behind an explicit, per-partition cpuset opt-in.
     Default off: partition changes never touch rcu_nocb_mask, so no spike is
     inflicted on other partitions.  On: the isolated CPUs join/leave the nocb
     set, paying the offline cost once at setup/teardown.  This is Waiman's
     admin-choice knob.

  3. Do the toggle inside the serialized hotplug transition at
     CPUHP_AP_IDLE_DEAD, rather than the remove_cpu() -> toggle -> add_cpu()
     dance our v3 prototype used, which raced with concurrent hotplug.

Open questions:

  - Frederic: is CPUHP_AP_IDLE_DEAD the right hook, and is a new cpuhp callback
    there acceptable versus the current post-offline API?

  - admin pre-offlines the target CPUs (your earlier suggestion) versus the
    cpuset code cycling them via Thomas's per-CPU down/up primitive?

  - does the "only RCU needs the deep offline" assumption hold for tick,
    managed_irq and the watchdog?

If this shape sounds acceptable we will build it on top of your CPU down/up
primitives.

Thanks,
Jing Wu
Qiliang Yuan
