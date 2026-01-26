Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F0A26299
	for <rcu@vger.kernel.org>; Mon, 26 Jan 2026 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769468731; cv=none; b=i+nhQ5/+nBqit9+rcjiZbOGD4XCSaVUAHd9C04+KQ42putGO0M9rdVNMQUSu7AGICp0y7nTr9aI0numnxzDmOdHur0uvN8S3OOCgO5ArtN6w15Pdj08DaAPg2e0o4mX1/nPJFKWIUAwKEZnMyhj9gITmXsmMKOxKOxe4etE2UFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769468731; c=relaxed/simple;
	bh=mT2BeWiw9kYkT94ehH+6RGyKnQvJ4GqAP08tkE6v3Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOhNrzFDY+cBHAMuUFItYo+iL0SVSXZsuN0ikP590z9Vve8WGVBHjYUXBYBzyn+7WPYiu39hXxAhp49faYyPG1wstwfGRFtWprgA/mzeF/G5BPoP8LTW8WaJVbKO2SpNdXp/81CTtZZQUbB4LUlnjdVigM5oGFXPPC0SFwBfTuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=KOempiZa; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="KOempiZa"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82318702afbso3748517b3a.1
        for <rcu@vger.kernel.org>; Mon, 26 Jan 2026 15:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1769468729; x=1770073529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K79P9yEEOhjx+zO5nMMghB4fcEf+uSORL+5ZaRYOorU=;
        b=KOempiZa3Kq1mOC2IeeivJCxr6apeoOS72MjW7oBtp0R6gZM2g8rUZSxCcSpftoxjr
         MWbqp8629J3AX+k44xP777A2XDTSMgCDqZ5T6yO/CYiJt2vtAx7ozvrIws10L65eVCrP
         JqWmGR1UxrmQjV94EMbdY6KYBcUUfnypy2sbSvn4deoqdPfgfga8CMYn2Mf59F+Pulnb
         /7mtloLXddE6fxN1yeOlwDWNp7o1xukba36L7zTT25Yh6dMIz1Y5MyrzRG6/Kx3+CXkB
         8MDRl1qm02Vp1HxAgJVb3NjhIuoa8+qW04Wch+ekTIvjqaK2KTqrziYOAGXytdEFXtzr
         Cn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769468729; x=1770073529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K79P9yEEOhjx+zO5nMMghB4fcEf+uSORL+5ZaRYOorU=;
        b=ZGKTyjAhMInuaJ4WcZ6FZnBQD0GeqT4czUAabomD1plkZCWAV5Q+6E4C8OKPV05Vvu
         myX5WWLKlPFdDj4D0ulVPEOqYib/xUCFFrP1E8cwAQJcIsh9OyhAggGd5lhhlyXnCH78
         war+YkbRn9p4FIZHpay7qCqwaiVqnV0Z+Bhd5D4mETws3bp5uA0iIzSReUwvE+01jV+R
         0nMa5sFl/x6Hqzo4IjsWeogWzuujaXIuSNhR6j3jdfkvNz6mq1QVNcNj/m8MGN/Ovmcq
         2egECfQAs6JQ11yd6p6I6C5XicI4TTjaJi6CZYymxaruSQwwUi3feOG8ylpSSNq85w2W
         y/7w==
X-Gm-Message-State: AOJu0YzdiXqmbsSi2EHT3k2W5vqgNK1BpCtE/2PlMqxSEJ/PY9Yxr360
	X4Jo7bR9tj1oflNuRe0kvkKlL6d9ljpHGOstzfQB0dN8EfyUD9MNe+QQxcAiuqP15B0=
X-Gm-Gg: AZuq6aIFvu4hpiR9ujOfuQqcUDY6zylRWkc2cGUjeIAkolt9lzXua/s3BOSiRxlZAaK
	ftUO5H32ZEI+Lg3kCGABwNZojDgJgiuffjQRNt9Kkzl5UFk9A80j/Owp26XVJ1YH8h+Bs/u0Yqv
	bxBj8FswqapdN9CUPQyfb0ce3b9df4jdjUnY4rgMAmEZvdtxQGP8YL55nvyJwedAQyzloNoX9Bf
	NT7/t0jZZsmBSZv2+oxR7rQqpxd8Ofhp7khtHApzNQk7b4Vgl8u2X/q6fCs/Kk2P0Jvisfi9S9W
	cDC3CGx4s/dla0WiUN+cTPaf0YwtrPcj/uo8YQA+PZ8/cAj5EntG0+/mH5p0I99mD+dkCGhYxO5
	wd9JLhq3D2+sf8UaE9OGZPg3ssDuTgQbBi9mpxtqqLTCHFNfdSPZT/Yic+7hetC2appj6GG+OnN
	PjWN29hS9Ac6d33b8e37F2TfVqhA1IDcv3sK3iKoTz478eYEhfZ0YX2HbprLmYYBHXGCUTUtNMk
	A==
X-Received: by 2002:a05:6a00:808f:b0:81f:38f4:d774 with SMTP id d2e1a72fcca58-82341219750mr5263349b3a.27.1769468729066;
        Mon, 26 Jan 2026 15:05:29 -0800 (PST)
Received: from dread.disaster.area (pa49-180-164-75.pa.nsw.optusnet.com.au. [49.180.164.75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82318671e1csm10235041b3a.27.2026.01.26.15.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:05:28 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.99.1)
	(envelope-from <david@fromorbit.com>)
	id 1vkVe9-00000008v0M-1zNf;
	Tue, 27 Jan 2026 10:05:25 +1100
Date: Tue, 27 Jan 2026 10:05:25 +1100
From: Dave Chinner <david@fromorbit.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	hch <hch@lst.de>
Subject: Re: rcu stalls during fstests runs for xfs
Message-ID: <aXfzNW7cf2ReVDA4@dread.disaster.area>
References: <aXdO52wh2rqTUi1E@shinmob>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXdO52wh2rqTUi1E@shinmob>

On Mon, Jan 26, 2026 at 11:30:17AM +0000, Shinichiro Kawasaki wrote:
> Hello all,
> 
> I regularly run fstests with the kernel at xfs/for-next branch tip to validate
> the capability of zoned block device capability of xfs. Recently, I started
> observing hangs of the test runs with the message:
> 
>   "rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:"
> 
> The hangs occurred in different test cases, and simply rerunning the test cases
> does not reproduce the hang. When I ran the whole fstests test cases, it also
> fails to reproduce the hang. However, when the whole fstests is repeated the
> hang is recreated. The hang looks rare, takes very long time to recreate and is
> tough to chase down.
> 
> To tackle this problem, I would like to seek the expertise of rcu developers. I
> have attached kernel message logs captured at the hangs for analysis [1][2][3].
> Any insights or guidance on how to debug this problem will be appreciated.
> 

Nothing XFS related in these. All the XFS traces are waiting on IO
submission - the block layer below XFS is typically sleeping waiting
for tags to be allocated.

> [1] hang observed on Jan/23/2026
> 
>      dmesg log file attached: generic_005_hang
>      hanged test case: generic/005
>      kernel: xfs/for-next, 51aba4ca399, v6.19-rc5+
>      block device: dm-linear on HDD (non-zoned)
>      xfs: zoned

The block device has an expired rq so the timeout work is trying to
run synchronise_rcu():

> [272416.203262][  T167]  wait_for_completion_state+0x21/0x40
> [272416.203719][  T167]  __wait_rcu_gp+0x1cd/0x410
> [272416.204487][  T167]  synchronize_rcu_normal+0x4a8/0x510
> [272416.207632][  T167]  blk_mq_timeout_work+0x4aa/0x5d0
> [272416.209324][  T167]  process_one_work+0x86b/0x1490

So that's possibly why IO is stuck. i.e. the block device is waiting
on the RCU grace period to expire, and RCU processing has stalled
for some reason. Hence the block device appears to be a victim of
the issue, not the cause.

> [2] hang observed on Jan/18/2026
> 
>      dmesg log file attached: xfs_598_hang
>      hanged test case: xfs/598
>      kernel: Christophs' xfs branch, ec6aea2a5 v6.19-rc1+
>      block device: TCMU (non-zoned)
>      xfs: non-zoned

Looks like some kind of scheduler/static-key livelock or deadlock.
There are a bunch of tasks all doing stuff like:

> [164582.112175][   C10]  on_each_cpu_cond_mask+0x24/0x40
> [164582.112179][   C10]  smp_text_poke_batch_finish+0x45c/0xd20
> [164582.112218][   C10]  arch_jump_label_transform_apply+0x1c/0x30
> [164582.112224][   C10]  static_key_enable_cpuslocked+0x16c/0x230
> [164582.112230][   C10]  static_key_enable+0x1f/0x30
> [164582.112235][   C10]  process_one_work+0x86b/0x1490

Along with the rcu_preempt thread apparently spinning trying to
reschedule:

> [164661.054667][   C12] RIP: 0010:__pv_queued_spin_lock_slowpath+0x232/0xdc0
> [164661.054745][   C12]  do_raw_spin_lock+0x1d9/0x270
> [164661.054768][   C12]  raw_spin_rq_lock_nested+0x24/0x170
> [164661.054774][   C12]  _raw_spin_rq_lock_irqsave+0x41/0x50
> [164661.054778][   C12]  resched_cpu+0x62/0xf0
> [164661.054783][   C12]  force_qs_rnp+0x67d/0xaa0
> [164661.054799][   C12]  rcu_gp_fqs_loop+0x948/0x11b0
> [164661.054841][   C12]  rcu_gp_kthread+0x4f2/0x660
> [164661.054876][   C12]  kthread+0x3a4/0x760

I can't find anything obvious in the block layer waiting on RCU.
However, XFS is waiting in the block layer on mq tag allocation for
submission (like the 005 hang above) or waiting on journal write IO
completion, so the block may may well be hung on RCU again.

> [3] hang observed on Jan/14/2026
> 
>      dmesg log file attached: generic_417_hang
>      hanged test case: generic/417
>      kernel: xfs/for-next, ea44380376c, v6.19-rc1+
>      block device: null_blk (non-zoned)
>      xfs: zoned

Same static key pattern in on_each_cpu_cond_mask(), there's also a
bunch of tlb flushes stcuk in on_each_cpu_cond_mask(). rcu_preempt
thread is not waking from:

> [74627.121083][    C2]  schedule+0xd1/0x250
> [74627.121959][    C2]  schedule_timeout+0x103/0x260
> [74627.128027][    C2]  rcu_gp_fqs_loop+0x208/0x11b0
> [74627.135240][    C2]  rcu_gp_kthread+0x4f2/0x660

There is nothing XFS or block related in the hung task traces
at all.

IOWs, this looks like some kind of RCU/static key/scheduler
interaction which may propagate into the block layer if it needs RCU
synchronisation. Hence it does not appear to have anything to do
with the filesystem layers, and it is possible the block layer is
colateral damage, too.

Probably best to hand this over to the core kernel ppl.

-Dave.

-- 
Dave Chinner
david@fromorbit.com
