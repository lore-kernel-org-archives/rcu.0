Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFC01F4611
	for <rcu@vger.kernel.org>; Thu,  1 Jan 2026 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767256885; cv=none; b=bS+RAs3LMK+xFJPS2vHx1Z3OGjqxSzQVcF8qw7BHkmqW2dGDAjGo7/AHsTrUKmpZ2TFWJ8/HVCEo43geqDG1953g0x/nUSRKDmJeSviL5vXRZ0EOcmuMUSvOo6X+f97xNZ6W+7ZtPRzpUZovbepQF/3GH3m41B1ykw+2Ae8YLl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767256885; c=relaxed/simple;
	bh=svkhMwu6oymZ0b23SiXMNK46fqqtLreevU3q1uPbk5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwkaIPXeWyJwRhSS13e0z291acU9BPa33VDYkkSMRnIHOPL8ZY7MPVsFCwrXbkGxDYdomjbF/nWZPBmkVwCyQuixJ6PHjKad163/WetBNJ9UdtUDzqyw0MqqyQmi1zz7C8UMCBWVKJz8tuq3eWMps7hZbVRu27M6L5mcM1j8qyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPJ/LjcR; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPJ/LjcR"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8888546d570so167206436d6.2
        for <rcu@vger.kernel.org>; Thu, 01 Jan 2026 00:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767256882; x=1767861682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpVzcws5C+jZn+Pfhh9yiEP87fgzN3EOEhsoU/gcpBI=;
        b=aPJ/LjcRUzCGRx2a4Oz9FQVH+gZuohrzcvy0Rjxaa+I+2UwP61GffD1DuKKpNZgj3H
         SuA5qoVG/1mlcmNBVD7ywrS3I7P4YTB/oav6GND4qYqHVfj7J793qG1dmJZeB8/OJEq7
         fmyB1Qk5ST5xlRmEDmLqnN/qxxS+b8ctCxeIlclbqFry9Y/1bTPjKdIjsvnglRYxDxK4
         mle/ZDoxaPvJRmY1zKlfa5HYh26GbR75MjuYyDD45VPcH83tTP7xwPUR1hlinOhPCHCX
         /9NMoPc6oDe9a8xm7uriHWnZO4MTJsIK+kNONrxCL+wRHTLK4CLsARpQXF6mawWWycIG
         ZLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767256882; x=1767861682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BpVzcws5C+jZn+Pfhh9yiEP87fgzN3EOEhsoU/gcpBI=;
        b=Kr3e14pTwhWsPs3I4nt89qNJ2FYeY/atABBim6WeUvMebZjQdcBqPEnVoL5rw7x8wc
         2pjXEqiGAAVAr4ZoYHtK5wbsRghg0XPe0ddSKmxFQMScymAbw+TRtRY4kOUgFcis4nR1
         G9lZ6Bj88rgDnqYAxCv8uq0bdsbRgTVXzwlfWgxpCP0Elds5kTBYlaWwnNJSKH5eopFu
         tcddWsxRD9SKsX7lvuFkrUqo1qTxglLOvbNSpAK/JYv6G5C22i/QLbSKqRMVuOGoPvKY
         iW3n9fuW8PrnClakBaq9IRiLhYDvjrFewjLC7h7WN6O9W5ouYoyPPE87u0KE2nvQBt/M
         xcyg==
X-Forwarded-Encrypted: i=1; AJvYcCVoYdJThPiJTWxRCNPiZXgJ2wmhYUiB6IXJ9gme8z+WnyBu0dH2lV24osL1ShmWLxZqwTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7bO9W/xwiSIvZK5nRGnBIGU6A4krcyQrl77CPWyaHOiDOCRxw
	PxOQ7cVBb3X+iJCe2KUtgV1xfYel3Ww3CjECTguk47mX6uq7ME8xNgMa
X-Gm-Gg: AY/fxX5uApRljwhNUc/hakVy4D40lj5Zm4JR3DhmWpsbejiLU3c2etAImeoDBPEJedg
	/dcExbmEJLjkD6uUjfn4OzzDKwsuEPNOwngFRXQei4krLppZKt/7rZUe/Z/UPn74Xxi0BxLmS8W
	x1to8l1C8ZH1rWoKHJnTOFZKRsw3eNCdjEPleXHnab6vvM1By4G3cpVaQx/6gdHZKJS7k/xD7YD
	RvY37/utrC20WmbualWj+ijw7KcfmzCf5B4RirMxi2oyvjxlARTINs0E2G6llCAUtK3yXPWEGQf
	1gJG7AlvIsG5pl4xfoFcA5ZEgXr5lX32zD2/QeTRkcjwiwFO11mj8BULQfWgKZi00V7Mgn+/7Ly
	y8rPnV94/9SRq2mnaOD0b0k5TAcwZVwuXMIs2a741lSZLYljM5etTcTWOhN/IVEiOJGnoFO4zW6
	nZb9l69jCBqH4lMbx/GJoTVcla+ct0t+j3dn5LbJwWiFPbZ0DcECQhSl6kuff5PfA4aTyr7Kpgp
	I1UuvvvTwM+tvU=
X-Google-Smtp-Source: AGHT+IG5lGey8pisVJdOo0PeIhCqoESFnDpRIMrlKut1CPmTVAJSNtJWymZjMP+S4Bl7ZCFIdXxYSQ==
X-Received: by 2002:a05:6214:5b0e:b0:888:3056:dc9e with SMTP id 6a1803df08f44-88d87605d8dmr619296976d6.43.1767256882490;
        Thu, 01 Jan 2026 00:41:22 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9624015asm330396376d6.6.2026.01.01.00.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 00:41:22 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id B7B5DF40068;
	Thu,  1 Jan 2026 03:41:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 01 Jan 2026 03:41:21 -0500
X-ME-Sender: <xms:MTNWaZeu79h5DGPPwjeTJM6kQX5BEJOAwGkrqloeCJMkYFnkSUInEA>
    <xme:MTNWaX5uzCilAsPMblu7rXwUomqAW2z--vY-Z5hJn3zCWXyLOoOVvbYFbFMg8zE3Q
    Mm-Loc7f6NCLvAOfBBc3mdy0ti6_TVWBol9FbwcrgQjVPLjdAV1_Q>
X-ME-Received: <xmr:MTNWaQsULXLSTCK8L-VgQG5-5iS2oo4kzNcJFWuuH_dW69WfYrxS25MZEAAx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekheefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    jedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhovghlrghgnhgvlhhfsehnvh
    hiughirgdrtghomhdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    khgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhmpdhrtghpthhtoheprhhoshhtvgguth
    esghhoohgumhhishdrohhrghdprhgtphhtthhopegsohhquhhnsehfihigmhgvrdhnrghm
    vg
X-ME-Proxy: <xmx:MTNWaXjKpHPVw4JGBFzlvsgMBRj1IYvWlhA_jLaQTKozsmTqmsu_RA>
    <xmx:MTNWabpgjHVZX7PtaCeDXsG94mPOQw8zrvWD36JJOoE1b1gn7RZJ7g>
    <xmx:MTNWaUtGjTEOsNOmNt6kqzDl07Y99PskLnhFydgaPa28oqqV5v37mg>
    <xmx:MTNWaeYN_3CIWED9_gtbMg7i08A8pluVYa_fjxUeHOQfSWZNxnWE_Q>
    <xmx:MTNWabasBvwgoFvg0tux8xhBF98QzFDC8a-1g0gqa8yh5fyixc8xA0sR>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jan 2026 03:41:20 -0500 (EST)
Date: Thu, 1 Jan 2026 16:41:12 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v4 0/9] Implement RCU Tasks Trace in terms of SRCU for
 post-v4.19
Message-ID: <aVYzKOqWalI3GgL7@tardis-2.local>
References: <b206b083-f611-43b6-993f-78ddbe315813@paulmck-laptop>
 <20251230231911.GA2605197@joelbox2>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230231911.GA2605197@joelbox2>

On Tue, Dec 30, 2025 at 06:19:11PM -0500, Joel Fernandes wrote:
> On Mon, Dec 29, 2025 at 11:10:55AM -0800, Paul E. McKenney wrote:
> > Hello!
> > 
> > This v4 patch series re-implements RCU Tasks Trace in terms of SRCU-fast,
> > reducing the size of the Linux-kernel RCU implementation by several
> > hundred lines of code.  The patches are as follows:
> > 
> > 1.	Re-implement RCU Tasks Trace in terms of SRCU-fast.
> > 
> > 2.	context_tracking: Remove
> > 	rcu_task_trace_heavyweight_{enter,exit}().
> > 
> > 3.	Clean up after the SRCU-fastification of RCU Tasks Trace.
> > 
> > 4.	Move rcu_tasks_trace_srcu_struct out of #ifdef
> > 	CONFIG_TASKS_RCU_GENERIC.
> > 
> > 5.	Add noinstr-fast rcu_read_{,un}lock_tasks_trace() APIs.
> > 
> > 6.	Update Requirements.rst for RCU Tasks Trace.
> > 
> > 7.	Deprecate rcu_read_{,un}lock_trace().
> > 
> > 8.	Create an rcu_tasks_trace_expedite_current() function.
> > 
> > 9.	Test rcu_tasks_trace_expedite_current().
> > 
> > Changes since v3:
> > 
> > o	Rebase onto v6.19-rc1.
> > 
> > o	Wait for arm64 per-CPU variable speedups to reach mainline.
> > 
> > https://lore.kernel.org/all/a1e505e4-931b-45cf-8ca7-337442aa598e@paulmck-laptop/#r
> > 
> > Changes since v2:
> > 
> > o	SRCU improvments not strictly related to RCU tasks trace have
> > 	been moved out to a separate series.
> > 
> > o	Use the new DEFINE_SRCU_FAST().
> > 
> > https://lore.kernel.org/all/7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop/
> > 
> > Changes since v1:
> > 
> > o	Consolidate RCU Tasks Trace cleanup patches per Alexei Starovoitov
> > 	feedback.  This explains the decrease from 34 patches in v1 to
> > 	only 21 in this v2 series.
> > 
> > o	While consolidating, consolidate the noinstr-fast patches and the
> > 	DEFINE_SRCU_FAST()/init_srcu_struct_fast() patches.
> > 
> > o	Upgrade comments per Peter Zijlstra feedback.
> > 
> > o	Extract Tiny SRCU bug fix into its own commit per Andrii Nakryiko
> > 	feedback.
> > 
> > o	Switch srcu_expedite_current() from preempt_disable() to
> > 	migrate_disable() for PREEMPT_RT kernels per Zqiang feedback.
> > 
> > o	Apply tags.
> > 
> > https://lore.kernel.org/all/580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop/
> > 
> > 						Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> >  b/Documentation/RCU/Design/Requirements/Requirements.rst |   12 
> >  b/Documentation/admin-guide/kernel-parameters.txt        |   15 
> >  b/include/linux/rcupdate.h                               |   31 
> >  b/include/linux/rcupdate_trace.h                         |  107 +-
> >  b/include/linux/sched.h                                  |    1 
> >  b/init/init_task.c                                       |    3 
> >  b/kernel/context_tracking.c                              |   20 
> >  b/kernel/fork.c                                          |    3 
> >  b/kernel/rcu/Kconfig                                     |   18 
> >  b/kernel/rcu/rcu.h                                       |    9 
> >  b/kernel/rcu/rcuscale.c                                  |    7 
> >  b/kernel/rcu/rcutorture.c                                |    2 
> >  b/kernel/rcu/tasks.h                                     |  621 ---------------
> >  b/scripts/checkpatch.pl                                  |    4 
> >  b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01 |    1 
> >  b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02 |    1 
> >  include/linux/rcupdate_trace.h                           |   81 +
> >  include/linux/sched.h                                    |    5 
> >  kernel/rcu/Kconfig                                       |   25 
> >  kernel/rcu/rcutorture.c                                  |    1 
> >  kernel/rcu/tasks.h                                       |  121 --
> >  21 files changed, 219 insertions(+), 869 deletions(-)
> 
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> 

Queued, thank you both!

Regards,
Boqun

> thanks
> 
> 
