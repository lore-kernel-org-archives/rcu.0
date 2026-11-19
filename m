Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081145;
	b=KvD1LOPgpzIAySu3m/3VZNP29poA/5A/FVn3RyCjDivyabvsgJeLy68G9kdrWOWvL/LQ
	 5N0re0727X3ydhBqBMf+DEehDfDl3uO7gfg4p4VxR5dOBqsUlBhwUHt0dTFfm+b+krzLt
	 BkWnK/ELKMcK2gnMLTT6aWQws3QwDGaVLTgGWPSO4pR05MjPwVXKlebhyffTAUip7mfdi
	 eF9jbSaBl42+2TRu6JjmLMFTWEgIgUg0uUB20zAu8vevTpxz9RsPqqb+kKs6da7UqGd2o
	 FAo7c6km/d7EpQVv6Fz74WzER6XOu8uQvUsWIyPpDH8hv+B78CTPIJVBXXqNnt1+WlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081145;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=pMk3uCL/mMFFLt4CcF6GxweeCli7kRS/xysE6ODU9FE=;
	b=WD5pCdmyWgnab6jgio5PE/x2LgeYntA1x2OhgeXp2daerj77nVjO/GUpioGfHsbD7sSS
	 6xcOt1Efy9mTwEkdaKcGrtQRVUnD2djDEKct/nuyGZQ2O2exyJYBwpmuYyNDG312oLgOJ
	 Tb3CsovqAjabEJS7zDAu0eh/adX2zWvKhMbFm82Y8aasxYj38G4GcrULHSCMFYd+3kd2L
	 a74QMTarQA8Jzg7bmSOh7cH5bCvoI6DPmqv+VYLRAJpfC6q8+4DKRxdKQMp06ZOZ2ivAI
	 DMF3DHqdfj1yhnCmpo13w/M07ysHR5Vq0iQXzG2E1v+ympS1jmRggawyyQiatKTtj2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=vgvDCJ7K;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=DL3HIRkg;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227B4606A320;
	Thu, 19 Nov 2026 09:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 227B4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=vgvDCJ7K;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=DL3HIRkg
Date: Thu, 19 Nov 2026 10:39:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795081143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pMk3uCL/mMFFLt4CcF6GxweeCli7kRS/xysE6ODU9FE=;
	b=vgvDCJ7K4pS8WZOlGqNgkzVilecewUDWZoUt81Xjh6EfmySP5kZv+3iTD1BCmLggXorP7f
	bV7BfUrfhB8i9OGKBCBcr6VlUWqJJwPldz/iHD8ICmJx33bEQdnSlTIsyTy7abwrJU4Wim
	W3Rlml56w1vmTBGE6kNVvn4tPWWANZiI/hUVOXF4jRxJfOZ9Q6sQlyR70atJPvtyV4vLwo
	IOdTNTE5Sx+5qw3EKTp6rwgI/Bp/0N9ua2simjk4F2NU+ixsTkNoeb6MelKx+Yi2Rg04br
	wMu5sy/vbl+XbBckzg8CKomNOUuZbxzmWamHpoRUHQNQY2BT16NMbo1eWp7WBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795081143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pMk3uCL/mMFFLt4CcF6GxweeCli7kRS/xysE6ODU9FE=;
	b=DL3HIRkg9eLQoR8/VykM7L0Voyn1Qng4b2qTgLK4PMTySW4iYGj9eDlSDgo7FnbAAjHbpU
	HZf9Ew+2V2KdTOCA==
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
Subject: Re: [PATCH v2 4/7] doc: Document rcutorture.test_boost_reader_ms
Message-ID: <20261119093901.Gtf9Mom6@linutronix.de>
References: <20261116194438.306618-1-jfern@kernel.org>
 <20261116194438.306618-5-jfern@kernel.org>
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
In-Reply-To: <20261116194438.306618-5-jfern@kernel.org>

On 2026-11-16 14:44:35 [-0500], Joel Fernandes wrote:
> Add the new priority-boost reader CPU-time parameter to
> kernel-parameters.txt.
> 
> Signed-off-by: Joel Fernandes <jfern@kernel.org>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
