Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D252D0631;
	Wed,  5 Nov 2025 22:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383372; cv=none; b=etmqCDfw+8imrjQrjzN8QV0ZEcbybfVn3wMZMYX2T1mcJhjHkmnM+7r4SquXbGz2eIaKPha2nNVj1Ej8YfjeVop2qI67O8i5D5DYAPjoYDRqF2idP9P8n0b7T310eMyKLfPdfT0QkM8gskLogPImP6Y7H0mlIPNFTq8MLCRSNfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383372; c=relaxed/simple;
	bh=000gXNvubZXtwKQCdVdjoEnT3fa/nqgkb/qx5r3C8t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6TFYbK4CMViMW5dtbCetHbCZKRP8oOe6jWpc5PFj8MNMH9BBUqbgPk1wnNltge9Ty2iS/2+k40zwFPRXEtWd3V7+bFF759eRO+8obP0V8QJK8Z3lrg2c5w5NvhOEde4MQUczopXz++BUmEmqunCO2wLy1vLcKGjlB65152JxTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSd9bzCT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSd9bzCT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7608C4CEF5;
	Wed,  5 Nov 2025 22:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762383372;
	bh=000gXNvubZXtwKQCdVdjoEnT3fa/nqgkb/qx5r3C8t0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DSd9bzCT8Gqop1D49QBUXCpwqceT6wfW7U8uTSEGF/9AFDpwnxKLfRlEj2jgl9l9v
	 3k/vVwyRtfkp7uvDZI4EVmK8xPyPSxhFbWezTvJ5fT0EEO2+WfTb431oE45W+5lIhZ
	 Krelhha8oHvUAHXKOw/cXkksted3CLnGmpKZz9UpbHCbsEbfxAZcE3X6+zv4V5ljA9
	 y2EzKOr5sPsPnZTwe9LaZRpmFWBBZ+VFG+vuQ79tKlzlxlsypt3NtD85X+rvXkNqYa
	 6tHwTle+1V+UcBQ5/jk9XwZqkrA4jbL2P655WY8iPnEHAge7CoJYq5Lj/QJjkRn58P
	 nJq6854ZfQYsw==
Date: Wed, 5 Nov 2025 23:56:09 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 0/8] refscale updates for v6.19
Message-ID: <aQvWCaUWTDvfIUiE@pavilion.home>
References: <19fae851-0c49-43d2-9bbf-913424641ff4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19fae851-0c49-43d2-9bbf-913424641ff4@paulmck-laptop>

Hi Paul,

Le Sun, Nov 02, 2025 at 02:49:34PM -0800, Paul E. McKenney a écrit :
> Hello!
> 
> This series contains additions of microbenchmarks to the refscale suite,
> and depends on the SRCU series.
> 
> 1.	Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast().
> 
> 2.	Add local_irq_disable() and local_irq_save() readers.
> 
> 3.	Add local_bh_disable() readers.
> 
> 4.	Add preempt_disable() readers.
> 
> 5.	Add this_cpu_inc() readers.
> 
> 6.	Add non-atomic per-CPU increment readers.
> 
> 7.	Do not diable interrupts for tests involving local_bh_enable().
> 
> 8.	Add SRCU-fast-updown readers.

But this series depends on the "RCU Tasks Trace in terms of SRCU-fast"
patchset which isn't for 6.19, right?

-- 
Frederic Weisbecker
SUSE Labs
