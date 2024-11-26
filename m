Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856B61C462C;
	Tue, 26 Nov 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732631429; cv=none; b=gmTWOCdEEj4YNKuFao+jP0W9h2n8juMnbJ7Q2ix15xthfJIee5pHprTGrwMemYqAkHHeDltZ40DtQt3hr1Q5YXLC2dRr03S57eouJ8hlFQjB4HxfbxmzYCHSwDMulbtwLjcdqcEkHokJQ0ypVBKu2+qtIq/qSQqMYDf3eDa7VSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732631429; c=relaxed/simple;
	bh=U+g5SdLhuDmbL8yMy6mAt3sK3+3vUWmO90kft4ugjMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9imbiLUrFVc6q4ClyZmqad8Y5+uiEW2rM9sy2R4AYZ1YUv9HKw7ncK2QUVn3iSa9qeDRtaa9NOEhAo3479p5vZ0GOhX3KzvpKo4QHpNJ1YO7IqPSTHW27ju9kmIWRf9CCa2w4ROCmZRuLGH/NNeXvinqxQvGCy7BkhJWl1N5XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=459oP4FP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BHXjf1yh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="459oP4FP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BHXjf1yh"
Date: Tue, 26 Nov 2024 15:30:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732631425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2OfacT2m8yJJipzhDS6AnEuqGANNTVmIaCcvcEovSoU=;
	b=459oP4FPoVvKZ8vaMMG/kZicrIK5ljE/DCFTuUylOL3oWJL1wOLB1BYoHpdVG8WV0DNrmv
	bXeHCDb/AzX3UIwLihersY/v+r+jfsL05e7b/q2Hpjj7lp52SkpzspAF+vekhFvPFZyOa4
	7qAD5h978c+p+883ZjY/G7796rxHE5SRDaekfzwQGxYdJSrbUnDCOJgyqAX1Bj5zhyBB9f
	SRugIMloTPgZXcRzrry+kio7j/eBWpKXciHZj0uJPKk4RHIoAOTpzhG81tS6jxwLtEEijz
	roAEkeJFoml2h+J1Z6MmKHjY6RRn69Ljb0qDwl0bNUH8QPp8CEiJ58useMUN6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732631425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2OfacT2m8yJJipzhDS6AnEuqGANNTVmIaCcvcEovSoU=;
	b=BHXjf1yhlyQSiCuDlWWxZa5DxQxssbOvD0wjejeFBu4vNickl25dvgW2P/G2C+m8ATTOah
	6A6X/PvYGbXugaAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Subject: Re: [linus:master] [sched, x86]  476e8583ca:
 WARNING:at_kernel/rcu/update.c:#torture_sched_setaffinity
Message-ID: <20241126143024.EKo6QfKL@linutronix.de>
References: <202411252253.e39d77c6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202411252253.e39d77c6-lkp@intel.com>

On 2024-11-25 22:29:09 [+0800], kernel test robot wrote:
> Hello,
Hi,

> by this commit, we see the config has below diff:
>=20
> --- /pkg/linux/x86_64-randconfig-161-20241120/gcc-12/35772d627b55cc7fb4f3=
3bae57c564a25b3121a9/.config   2024-11-22 17:03:32.458344665 +0800
> +++ /pkg/linux/x86_64-randconfig-161-20241120/gcc-12/476e8583ca16eecec0a3=
a28b6ee7130f4e369389/.config   2024-11-22 17:02:59.440805587 +0800
> @@ -121,9 +121,11 @@ CONFIG_BPF_UNPRIV_DEFAULT_OFF=3Dy
>  # end of BPF subsystem
>=20
>  CONFIG_PREEMPT_BUILD=3Dy
> -CONFIG_PREEMPT_NONE=3Dy
> +CONFIG_ARCH_HAS_PREEMPT_LAZY=3Dy
> +# CONFIG_PREEMPT_NONE is not set
>  # CONFIG_PREEMPT_VOLUNTARY is not set
>  # CONFIG_PREEMPT is not set
> +CONFIG_PREEMPT_LAZY=3Dy
>  # CONFIG_PREEMPT_RT is not set
>  CONFIG_PREEMPT_COUNT=3Dy
>  CONFIG_PREEMPTION=3Dy
>=20
=E2=80=A6
> commit: 476e8583ca16eecec0a3a28b6ee7130f4e369389 ("sched, x86: Enable Laz=
y preemption")
=E2=80=A6
> 	runtime: 300s
> 	test: cpuhotplug
> 	torture_type: trivial
=E2=80=A6

> [  150.797530][  T445] ------------[ cut here ]------------
> [  150.797915][  T445] torture_sched_setaffinity: sched_setaffinity(445) =
returned -22
> [ 150.798353][ T445] WARNING: CPU: 0 PID: 445 at kernel/rcu/update.c:535 =
torture_sched_setaffinity (kernel/rcu/update.c:535 (discriminator 3))=20

I've been staring at this, and this is actually fine. Your config changes
=66rom CONFIG_PREEMPT_NONE to CONFIG_PREEMPT_LAZY which implies
CONFIG_PREEMPTION. The trivial RCU test there does sched_setaffinity()
while preemption is enabled and CPU-hotplug runs in the background. So
you get what you expect either by an attempt to move to a CPU which is
no longer valid or by getting migrated to another CPU in the middle of
your operation.

This is all fine. You need to update your config file or your test.

Sebastian
