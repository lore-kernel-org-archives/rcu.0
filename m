Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476358;
	b=faB28sJmK65nB6T/9Bvtc/H6P2FXT/L9OZJxbiKguZ0ZozFE5bZp2OEnYVZRg1X6MTXS
	 AtN+SQoT2vgAYaW2Oz0N1XaMMeW02/60jbhECCAobar2kBNnETFLkWisRM5xeRtrxaAA3
	 BJsf+x19iARMKobBo58aJlye7UtDmKWLdEplSVXgSZLmsa8z6/ZnXJ/tVf9aE7BTfIZOJ
	 OmFcQrwf83TNO/J6fNltmSCGJuEor1Iat6iVVJDI58pBQVQGzqQiAlfUueAoumMAiELJP
	 mj6Ph9uXk/nlTHMOVKPrHRO423McN6tlyH/iTaMgtNagv4UH9oYRnlaRo2nPJ/MBkbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476358;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=1V/SMDgMNpQSJkqUUUeZckTasGGWiAbNEvt6tPJx2mE=;
	b=2amH5/g4JuEkqfmGFrUbT3YZh4e8JwuHtTmKhZgxydxSjcetLhPcTNxdgddPd4ojtLfh
	 7YyH9q7iN1nGYFeu7gdZTcES/ZemDtcA830n1aNP/eutXdisK5DlWnj9eHL2xIancKYS2
	 rR7TG27QTkW/SOrkL2PM9tAwD0Uzcn+v6c2uY1lthVVBgUxF2o6aFaZeuMQ1Y6I3us/Af
	 RjL4rZX3HUBkhszVu1b7dvAKlA4jVIgcDu6MZGxFTj1CGEA8iUh5JiCVrSfLhfQURKgxE
	 MueYtJl2M1JLvfgh3ly7fZenIQ5gt0LVtaZu6dGTIDv+99XoKznrs9xrKE5qhXx2//g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=GE3es8v0;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9A2606A31C;
	Thu, 12 Nov 2026 09:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E9A2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=GE3es8v0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1V/SMDgMNpQSJkqUUUeZckTasGGWiAbNEvt6tPJx2mE=; b=GE3es8v0zycW9V7xKJI0M6bYys
	VHuZPzMhUah+Vrnvd5MgB6tJF/kD5V6fKZ/CLLnPkQTq2+y3eK5RB4qAs1Ycq7zBrhFrPBz2IYI8N
	eFAkFd2JWuMEHpXosf4YSG8KQLpLTL8qdhvNx799ij4oip3NV/hYaX82gwb703YMFw1Y+V1U/f2CX
	s3v4V/s7a4jAa2PJYhakPYNeoGdRqkRF6HugMbppb67Q1yk3+pSYEIjOk2JuUgCMDZ3nIVAimPAai
	1euocP92RsSh0fedn9KW32GO6wam+KyCk88oj8zF++e/WAlQMWmXdJ0hUqeJQ3IS1PlYNwpjFoLvG
	Gy+1SHfw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRRGy-00DruS-2W;
	Thu, 12 Nov 2026 09:39:12 +0000
Date: Thu, 12 Nov 2026 01:39:08 -0800
From: Breno Leitao <leitao@debian.org>
To: Song Liu <song@kernel.org>
Cc: rcu@vger.kernel.org, paulmck@kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org, david.dai@linux.dev
Subject: Re: [PATCH] rcu-tasks: Use pr_debug() for callback contend/collapse
 messages
Message-ID: <avWJMVvAuUEdjmuu@gmail.com>
References: <20261111053551.3367903-1-song@kernel.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111053551.3367903-1-song@kernel.org>
X-Debian-User: leitao

On Tue, Nov 10, 2026 at 09:35:51PM -0800, Song Liu wrote:
> Commit 5de907d24919 ("rcu-tasks: Disable callback contend/collapse
> messages by default") added the rcupdate.rcu_task_collapse_debug module
> parameter to gate the three pr_info() messages that report RCU Tasks
> switching between CPU-0 and per-CPU callback queuing.
> 
> The kernel already has a mechanism for debug-only messages that are off
> by default: pr_debug().  Use pr_debug() for these messages, and remove
> the rcu_task_collapse_debug module parameter, its documentation, and
> its boot-time announcement.
> 
> The messages stay off by default.  On CONFIG_DYNAMIC_DEBUG=y kernels,
> they can be enabled at boot with:
> 
>   dyndbg="file kernel/rcu/tasks.h +p"
> 
> or at runtime with:
> 
>   echo 'file kernel/rcu/tasks.h +p' > /proc/dynamic_debug/control
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Song Liu <song@kernel.org>

Tested-by: Breno Leitao <leitao@debian.org>
