Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080985;
	b=RgVuJVHFyruR0WEe6L+4bfjgufQyZvx82VkVLoj/WP3qCRm2hjv7k+EKXOg/7J8MzSaZ
	 s5hV+nXVHtzd0k6D48GPxKrwekCC9S8dEUKS39MmRDM4MiIssx+COHVgk6ibZiALLxcQR
	 qN2gu0z5NcgvyRUpmArJ3whk5deJXEM1b09ZA/a4dBqzuoRx5fTvqjX1YWYRcOjlNEtVe
	 GRS+ZbVkPnR+e+x1hDr1ogkBFVXxu6l6IKh26LPJl7KEFrtlW9aODuWuvuL/wJNLRTqgU
	 6bwB8/3nuceBftQCMg9XVpcR5ZqEdr9vr8PD92P0gY5T1bnlNwmRBMCEMKp13OxDwRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080985;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=xO2pdiJAnznJYS9IyGCtJ4fgt5Vc6SFkm4poXMVIIds=;
	b=2YEKVM/zgkP9FwgfBbyU5fm4+mowQ+glPs1kgbcSoIfBm6XTmROwtPglXyZhTT1EtXd5
	 dT/uwJ21NywgIOIMFjeEHMKMlyINah6VCVOZ0ZJeXayHu29a8LE+hoKN5scuUFpSIPbZJ
	 seMLqoToYg63iLLL4LPMAYvqGExkyQ5ZErYsPLceXFCRX8DbjiL15VX3VnHILuzXYqymD
	 dtqme32DKczUqhEz6sTaJwLGjJBxTfrxXpMdhIDObBYneWljMooyy/CYxNXFJDNBec9nx
	 Eb+dQ/e3m5fBOLkDpkpdtZHz6jKqhyyJ1Wyu1wIEqNoDVe6w+JLXqc3RDGM8/tAAwRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="IMJAGE/R";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=UawDgz71;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA19606A33B;
	Thu, 19 Nov 2026 09:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FA19606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=IMJAGE/R;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=UawDgz71
Date: Thu, 19 Nov 2026 10:36:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795080979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xO2pdiJAnznJYS9IyGCtJ4fgt5Vc6SFkm4poXMVIIds=;
	b=IMJAGE/RmMKCiFanlj/FD2Ai1vM70Xgkk3jslQIjbo+GMNoY8hWbLM2zoK5pftpJnToImE
	pA78Bc6KG904qKbrHr1GpF59kU/f2VGeIZ4+i0tguKl/fPvpPoj2S+0E102IqR20IQphl/
	xOKTYbUqUOB0zI8dsGOd5l2MgyFQx1N/wo9LbqqxJG8R1jDtKB9H+uUwimDELqAN0czePn
	ieqwRZVc4irSAANq6aa31sB3lwY7xna6X6EsxfV9URVuSFw/Bv6I3JluIWDa8ehgHy2JSf
	8pssgXd8nuTpiWjFwlJ2eIUlc7tdE14vdlMOxsrkFsyMjL1IokATGyw/aBm9iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795080979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xO2pdiJAnznJYS9IyGCtJ4fgt5Vc6SFkm4poXMVIIds=;
	b=UawDgz71m/pFyii/qCCSf4Qd3VGRXH6vVvdxBP97iLTWp2v3iuvOkpQWlxkXd4xAYIR/DT
	mX5mDpUZ+H/C3ZDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joel Fernandes <jfern@kernel.org>
Cc: paulmck@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/7] rcutorture: Remove unused check_boost_failed hook
Message-ID: <20261119093617._ZzpwlWf@linutronix.de>
References: <20261116194438.306618-1-jfern@kernel.org>
 <20261116194438.306618-4-jfern@kernel.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116194438.306618-4-jfern@kernel.org>

On 2026-11-16 14:44:34 [-0500], Joel Fernandes wrote:
> Nothing in rcutorture calls ->check_boost_failed() now that boost
> failure is decided by whether the reader finished, so drop the hook
> from struct rcu_torture_ops and its initializer.
> 
> That also leaves rcu_check_boost_fail() without any callers, so remove
> it as well, along with its prototype and its CONFIG_TINY_RCU stub.
> 
> [ jfern: Apply feedback from Sebastian to drop stray sysctl.h include ]
> [ jfern: Apply feedback from Sebastian to remove rcu_check_boost_fail() ]
> 
> Signed-off-by: Joel Fernandes <jfern@kernel.org>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
