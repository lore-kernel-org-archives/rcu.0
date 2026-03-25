Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC1634AAEA;
	Wed, 25 Mar 2026 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465835; cv=none; b=mV4BWUm+5Y5sFSvmwLwECduHP34eTvGP2/zzijF/1UwsKYuVP+eVmc+E1lTBqZOh83fzuEWEJf+26DvWymVDlQ1AQ9OIZpzp7Daud8gFR5jHD6eF2RqvSNVWf03B5iXplkYBC13kTI9iikGCoA080B/RU0BW8UjIJR6wYjz4y1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465835; c=relaxed/simple;
	bh=Lo6ndcQCWZVmKHCFLJp4pQnU/YoCge+YKln6F/OYjV8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XfMiHRXUHotFWiMvSvlzvjUMKtNITWdR0xt4bYO3hi0fzkvLdn/Udg69ob3brDr5h88YfgUgZxrykLrtGXUnXky2+B1F7jgx08n3jIzO6BVAug1OWG/8G4550YJWVbfJmADyu25iBw9dQLvpnyp7/Vz8geWLI30gcH7z2bU2VcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bFrGU6AI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gIbSUyRP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bFrGU6AI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gIbSUyRP"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774465831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GKVUaGDSXKw0u9JjViZSjUW3b0OD9tvOeFtCgE0TUWg=;
	b=bFrGU6AIRKmslDP/1J7bCWS8wF1w6bDG/rgM+mpg2F8KJyYTVjWSVkrLd1HQBEYEbnD6S3
	rHykYDVa0FSH2HVD3HWMafvnIZkEwmMu0tGLH7f3G/vyo4irmjE7zEA0pffFC9ZV2sEaly
	m7VqBBE/L7QVS3JKY87WZavEHFiRHheD/aIuyfW4i07il1NNJ44ePEC7kovHswia1btIRb
	EmP67bpDlfk5yu/Wp/Bkkp+isFaw+W0xaGiGjHXn13Lh/49nkQHKwphakO5k/NinYc1OBi
	ff562wYZvY1eLSsXtfwfxPyMiqYZawsEECU2J7/lJoLyuOk+yCwLCKI1tlpTPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774465831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GKVUaGDSXKw0u9JjViZSjUW3b0OD9tvOeFtCgE0TUWg=;
	b=gIbSUyRPnyrLcrCsaOYmR8i1N02bAkUQKNsraZEDU/XbtE1tZ1c4YXt43cx16UMgcYfB9Z
	iuBwliFX9vG7zJAA==
To: Vishal Chourasia <vishalc@linux.ibm.com>, peterz@infradead.org,
 aboorvad@linux.ibm.com
Cc: boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
 josh@joshtriplett.org, linux-kernel@vger.kernel.org,
 neeraj.upadhyay@kernel.org, paulmck@kernel.org, rcu@vger.kernel.org,
 rostedt@goodmis.org, srikar@linux.ibm.com, sshegde@linux.ibm.com,
 urezki@gmail.com, samir@linux.ibm.com, vishalc@linux.ibm.com
Subject: Re: [PATCH v3 2/2] cpuhp: Expedite RCU grace periods during SMT
 operations
In-Reply-To: <20260218083915.660252-6-vishalc@linux.ibm.com>
References: <20260218083915.660252-2-vishalc@linux.ibm.com>
 <20260218083915.660252-6-vishalc@linux.ibm.com>
Date: Wed, 25 Mar 2026 20:10:30 +0100
Message-ID: <87fr5nendl.ffs@tglx>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 18 2026 at 14:09, Vishal Chourasia wrote:
> Expedite synchronize_rcu during the SMT mode switch operation when
> initiated via /sys/devices/system/cpu/smt/control interface
>
> SMT mode switch operation i.e. between SMT 8 to SMT 1 or vice versa and
> others are user driven operations and therefore should complete as soon
> as possible. Switching SMT states involves iterating over a list of CPUs
> and performing hotplug operations. It was found these transitions took
> significantly large amount of time to complete particularly on
> high-core-count systems.

This changelog is neither explaining the underlying problem, nor
explaining why expedite solves it and does not contain numbers which
justify the change.

Thanks,

        tglx
