Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9436750B8A5
	for <rcu@vger.kernel.org>; Fri, 18 Sep 2026 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746521; cv=none; b=hxvC9jc9mHJ5sql1agi7hqSG3Ylo0YbrZIXeCS2QXM1CRimztSitk2EZcAG+sdQXq6X6naQg9A8lg5tMNCNgWO0TJWpy98p2gQh1ooFqxD4undz3B3HUQoMxUW1Tv/gZi5SHe1dmKzWx7eal8e6+EENUNdb8iTdb2Uwkbbj/KyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746521; c=relaxed/simple;
	bh=DCEr206mu1fTBop+5gRQZ8IwHub77AxoSPqpcC21zvQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBR0tGGBU7BiCXQaxc0OCTopk58ChEKiAwhtXN+KktgGxoF0qSk9pB4sGecMny2UJM0fyfoMZaozurMIOkfdJO2/lyTz493sq/nu41KG+yCVIAwaK4U2OTESRmkLBGApUK2V+1Qefw3s2yxjIgYufU6vlH/TSruvl58nWSuoZHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=I9s5XHNo; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="I9s5XHNo"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93910ad2273so114021685a.0
        for <rcu@vger.kernel.org>; Fri, 18 Sep 2026 08:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789746518; x=1790351318; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DCEr206mu1fTBop+5gRQZ8IwHub77AxoSPqpcC21zvQ=;
        b=I9s5XHNoEQAFEpTiKyUBYmi7CvbyYdxKeEMHiUca/70eL3sTULcbyqRvJlF1MqjBmj
         RNzbAVNCEgJGEal+4RQ8ntr6PLGbP5z0gyXE9+uQdVlhjR63am/plu/wsecYJ1g8pgrd
         mN34vX4oVkezFjW2UX+PvtK9YaHdkmJQpUK+qnt3y8zAgXrz/eOUSDhwfv4FczHnuvfK
         9bpOKTWN5zAa+caPL7hRG7ksELAMXLMBBNFR9k170p0AshyaULuWiiDbJ+pBipkBsDFm
         t9twEAM+LGJWDqQqdM7XW7GAXnxyZrYecfyLLJC7WOzmrH5aK5KlP8q2EFVPzghqa/r5
         mIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789746518; x=1790351318;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DCEr206mu1fTBop+5gRQZ8IwHub77AxoSPqpcC21zvQ=;
        b=vA+9T2p2bTw3JmmKEnV4sfHI9XgAk+9n+v+wbnEta5yMzRPhaoxGKVUcx/OEHvDgF7
         x1lCkFV2CUvxDEWrtTzaayY3tSKy9X2GogyknJshjgyLrtfPWZwRmldMAl/SWd4i34ok
         01DIznOSG88pSstX0pJpqv5ZH5FsQq8JYmTBOej6o4olSrWNDqpQWZDo5KOZ+dpyrj55
         lHkFt5jxQGTkMPnDA5O6ufCpFkeDhO8ygtz/XqjXIGe+yLVQ9gp4uvU+CG+rc8gDDVLS
         hY+6PgaXgCUp5dvGI0hoYLDoa4sIdm3eC/qpH8T0CFGOCF63CRWwOaVd//s95hYL0svM
         +UVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzyzGG0Z0vZN4Smx4JMKCO3uPoOucWeLcyRaf5ZXJz4TfiTtUgq2OLdEDB7aawb3FJtWDM=@vger.kernel.org
X-Gm-Message-State: AFuF++nwhgx6DhlhklLPEzM3VVwcdcXk6/gsPl4UVQcUAZCsFeYcmx+U
	Irqdn8Q4PlDUc7JK/OJo9gT62j1BC2GR0t+aACTVog/gwhVAtTwxwm8NLpACC9y3ZeHGpzM0ed0
	cM1mj
X-Gm-Gg: AYBFou0GPYLE/NHb4pmXE8ETYjH3z1Ortsr2wFCLaRc0mYOJ8C1LC6iITqEIzBPgekG
	dnDSexXHL5f2EsIM5dbr3zxGQdP7g1we46Ng+36kTsXvTTLGepwTkgp7fvOQLPjQPrEH06prBMC
	QmkaHV1mPfA7HYN94CWJ6Ru+nnnavh845hXr1P5d752ZJomGtvMik2tlwG5bD/CSzPeMu/ZCah2
	faZ4+HXj0OZc6TqAjFf3STBC/E2OkbglTyDkT0/ycmZ59PX8YOacjE956eiXjmgzmnp4zkhWQWv
	1EKdNSpyq5QmCvd8qQOg8uVW+oeKHzbkIGAZI07OrtBLgP6JkYF8u4hyQZ7M3y8H2Kf1WNL4r1j
	aOfrrET9Y8f1EKJ2UmLacOgpbdVAWwCP14hCWYgY9XSo0Ek+Ma+LzDTSGrrM8+dVLpHhFE8Cnqt
	+5BRz0W2q8jIFVo+SdHFFssG+tlhY4iO6Pt7hWYoTRp7j/Y8DXDtJ/wv1gVlmfjcPB/2/7wjwXs
	slwRKI6tddvEwF564Pq3mVuY909lzUQ/cOeoPbuC0cgFSkrFTlWtfgdgyFexRHx7q0=
X-Received: by 2002:a05:620a:2795:b0:939:6de8:43dd with SMTP id af79cd13be357-93bdc9fd82amr447343685a.49.1789746518332;
        Fri, 18 Sep 2026 08:48:38 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0ccabecsm172276485a.6.2026.09.18.08.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:48:37 -0700 (PDT)
Date: Fri, 18 Sep 2026 15:48:20 +0000
Message-ID: <adc0426b5f4c8137c1f97d7b148d7adb.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC v4 02/13] rcu-tasks: Add a Tasks RCU implementation for reader-marked trampolines
In-Reply-To: <20260918151031.2E0941F000FF@smtp.kernel.org>
References: <20260918-b4-rcu-tasks-preempt-qs-v4-0-63f0e9d69661@toxicpanda.com> <20260918-b4-rcu-tasks-preempt-qs-v4-2-63f0e9d69661@toxicpanda.com> <20260918151031.2E0941F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 18 Sep 2026 15:10:30 +0000, sashiko-bot@kernel.org wrote:
> However, the per-cpu rtp_exit_list list head cannot be statically
> initialized and is dynamically initialized via cblist_init_generic() from
> a core_initcall. Since core_initcalls are executed much later by the
> kernel_init thread, any preemption before that phase will attempt to
> list_add() to a zero-initialized (null) rtp_exit_list.

No, cblist_init_generic() is not run from the core_initcall. It is run
from rcu_init() -> tasks_cblist_init_generic(), which start_kernel()
calls with interrupts still disabled (the function asserts as much) and
well before its local_irq_enable(). The core_initcall only spawns the
grace-period kthread. So the per-CPU rtp_exit_list heads exist before
the first interrupt can be taken, let alone an irq-exit preemption; the
classic flavor's exit_tasks_rcu_start() already depends on the same
ordering for the same list.

Thanks,

Josef
