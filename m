Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DB0205502;
	Wed,  2 Apr 2025 07:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743579736; cv=none; b=cvZr/BU33X48DHsCex6LOzYTZpwqd4hqg2CZ9p5SaAPMOeLuRCcyRMrhBl8RcS/faYOVIlyEv1QEueuUyAP3RI78Ru29kV3S5RrG9aXHruug2BvwPGrVoIhYam6UsnBcb/SuwAxbiMbRr/yarI2PUdS67Z4nMDUmgcXCgiETuRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743579736; c=relaxed/simple;
	bh=KnKbDJA1kA48viXbmllalTvS/2sX0nni1xgBkhX6wLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CB3Zbp6+WvpgjCrEfG2CZRjVMEFR83/E4NrHeDc8tFsEgI4w+/VrYViP46kYYHfF225CaEl5S8Jv6ZPHVpIATK+LvsefREVwse7H0b3fMpAdHN5i6F+JkFINuVRhZ+lKIC36sTrrbO1ek3MAC5US6YYANuZWG00+0BBZhL3zumU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pfU5ory4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P8t/0myE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pfU5ory4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P8t/0myE"
Date: Wed, 2 Apr 2025 09:42:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743579732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M7FoU9Vn5b2mEEwL/fDfrwVAr2Y7ezbsNixs5npufvg=;
	b=pfU5ory4Vq6J/siMf0uJWhDmeZ3kyBAkJWUq8udLJ9qH3frYbj21h5In3ZCtEls0OTYlww
	7rklEfQaclTpAqzowSyGh19m4iQZ1bzZYhyLnzLgT/VH8ERYbbLFwsErG+7l67ccysZRf7
	klNNkm4xoTb8+pO6C+EpaZ9qPd7+Uoax5NEXIu3G0MXbqgPyUqPbPYCTD2nrcf3aTnjRFF
	y5xh9Qrt+3yyQUIB2Emz4b15q/HRmTMUc+76jKmPCd98zjlFW0qaRu5EPF+LDeS47YpGTX
	ByzEuKSgCXIfI5EOsLws9MI+k11MPtEsN+7zsR/xvLhVX1Dd/8rNrzbySDAPkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743579732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M7FoU9Vn5b2mEEwL/fDfrwVAr2Y7ezbsNixs5npufvg=;
	b=P8t/0myEb6v6yO7Nz73hdPoQ2klxdTV2NGQ2gTlMf454meWGTnnKcFZy7jK3sxYoOxtURW
	Fg+qtoE+S1EiUSCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v2 04/12] rcutorture: Make torture.sh --do-rt use
 CONFIG_PREEMPT_RT
Message-ID: <20250402074211.tibxg1fJ@linutronix.de>
References: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
 <20250331210314.590622-4-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250331210314.590622-4-paulmck@kernel.org>

On 2025-03-31 14:03:06 [-0700], Paul E. McKenney wrote:
> The torture.sh --do-rt command-line parameter is intended to mimic -rt
> kernels.  Now that CONFIG_PREEMPT_RT is upstream, this commit makes this
> mimicking more precise.
> 
> Note that testing of RCU priority boosting is disabled in favor
> of forward-progress testing of RCU callbacks.  If it turns out to be
> possible to make kernels built with CONFIG_PREEMPT_RT=y to tolerate
> testing of both, both will be enabled.

Not sure what you point at here: You can build a PREEMPT_RT kernel and
RCU boosting is enabled by default. You could disable it if needed.

Config wise you set CONFIG_PREEMPT_LAZY=n but in general
CONFIG_PREEMPT_LAZY=y should be used if possible. The preemption while
holding a sleeping spinlock is somehow bad for performance if a lot of
threads ask for it. But then it probably doesn't matter for testing.

You do set rcupdate.rcu_normal and rcupdate.rcu_expedited but RT has
rcu_normal_after_boot set by default. Not sure if this makes any
difference but I *think* that normal wins here.

> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
