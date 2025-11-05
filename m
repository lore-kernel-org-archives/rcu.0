Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A360F39FCE;
	Wed,  5 Nov 2025 23:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383705; cv=none; b=u4UPg+Dl4o5KiRPnJzkCZyF4lRSOZ70HOytIIUHJhMp4IDRDiNHZZmH85KeH8SsV2kqywsJ6ISjguFLUE5eLSGk5XoTSfa9ebyoqF6vZj3hlBsGb67PsH11VBKWRYhDbsGM74gUjB+DNhH2HK5QhBuUGz1Hg46T70JapK07wpBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383705; c=relaxed/simple;
	bh=ZiFgvxepfFleke6zCFLTO0eGN2cB5DQXFN6tTCUy2l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOjSMrngCSV+CjnVFfwgmwBLjwPCQ5Ad2MviRCUQPIhSAjTTe/KWiZYNZpWhSySSAbg/h3/uavJJo6Sv9JhfzYH53HoJ0ihzLqIBSA0jHy/8TjM0qeJngUNgQ9n9lwHDMx4gbHCuKEVaGO+Epugwx5UgRMVa8zoseEKaEbEr6kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crcWvPqC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crcWvPqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D96C4CEF5;
	Wed,  5 Nov 2025 23:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762383705;
	bh=ZiFgvxepfFleke6zCFLTO0eGN2cB5DQXFN6tTCUy2l4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=crcWvPqCJZ/Xp3xZyeiwg5iQoVtJ1F1FausvIvsUfdoggTLUPX49ROnrp6v8WqIfW
	 AQMu5Eq4Pem0hYdhen/KLLSXWsLgzQIsWBgxsr8U10YiTjAU0uzDMSMLFsKzYoz8Ov
	 deiyy5YS6O3Qz0IrBA8NnfB/IeW8hXR9DY2dCChTi9fQrXlE0b3iKtCadhobZ/5qGt
	 DihpRyLmh9j73keNNuXXeiEbHtOQQs7urZYVNttRQM0N54/JrToGKT+ir4ECTnUYN9
	 /fY6577TvM9Ae475Ccz7CquSjwctfSyEOvjM9NS8y+dAcf9zYOCrG7vnIj+A4nKHqX
	 /V8pR3ks8JcsA==
Date: Thu, 6 Nov 2025 00:01:42 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 0/8] refscale updates for v6.19
Message-ID: <aQvXVrsgE-Xz_aRB@pavilion.home>
References: <19fae851-0c49-43d2-9bbf-913424641ff4@paulmck-laptop>
 <aQvWCaUWTDvfIUiE@pavilion.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQvWCaUWTDvfIUiE@pavilion.home>

Le Wed, Nov 05, 2025 at 11:56:09PM +0100, Frederic Weisbecker a écrit :
> Hi Paul,
> 
> Le Sun, Nov 02, 2025 at 02:49:34PM -0800, Paul E. McKenney a écrit :
> > Hello!
> > 
> > This series contains additions of microbenchmarks to the refscale suite,
> > and depends on the SRCU series.
> > 
> > 1.	Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast().
> > 
> > 2.	Add local_irq_disable() and local_irq_save() readers.
> > 
> > 3.	Add local_bh_disable() readers.
> > 
> > 4.	Add preempt_disable() readers.
> > 
> > 5.	Add this_cpu_inc() readers.
> > 
> > 6.	Add non-atomic per-CPU increment readers.
> > 
> > 7.	Do not diable interrupts for tests involving local_bh_enable().
> > 
> > 8.	Add SRCU-fast-updown readers.
> 
> But this series depends on the "RCU Tasks Trace in terms of SRCU-fast"
> patchset which isn't for 6.19, right?

Ah it depends on the latest srcu posting, nevermind, got confused in my
inbox :-)

Thanks.

> 
> -- 
> Frederic Weisbecker
> SUSE Labs
> 

-- 
Frederic Weisbecker
SUSE Labs
