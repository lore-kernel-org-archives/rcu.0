Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567325;
	b=udQLGVkoNCcmqs4czpYT07sG6oHVjTU802XZh/V5SBTRLAF6bkOlAd+qrkK6N91jL5XH
	 jMmzmA3kCXAYCZ8eRLftwqkup6VKHXPeQaNBXJDnm62Jb+mRJpgk3cqsrF9V51Eywvb2d
	 MR1TJ8jF753TqXtWL8NshyWfbCbWbV4RU4L+GBFyBNV8zp/x2rr5k918qrfyZMNxpj7w+
	 xCwzsJj0RGTrVOBlEivaXo/smhw74rW+r9BFlN75zkUreqri6JS/i5ljeC0Zr9OHfKicm
	 CNOE2AvqfucPlBgQ37UsbvhXFXk7NevgVUoXpkkENt+ItPNUwqsZL8pzsY0wrDP6iZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567325;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=dVD2sgjeIdy2wIdfd/QmoCMe4rJiJI4y+gjhCqqw+84=;
	b=AfR64Wy6Ov75nnR9tmEi22km366vH9hmxXJW5T/ZTy4KlyiRAgSgKXyzG+4bkRrEteYq
	 vnL5Dm+wWXgNlFqZn0WfhYf56ITHAFvR30ceuDEDeizV5+It7g/cEWw1TBvAGCkUUJq0h
	 A9Ka5rv+aTjfEsGVtiZKgJLLgh8OwVK3sfsulIQ+xPLc4fElM7aaN6H3dCMyH7tNWB4Yo
	 0rn5ZR8/YLDPy7lyW5B8LI1tyWFLKNxOP9eN1/PAysFWwhe6QjcoSnl+ct7fEoBCBiikp
	 /o94u2y9X/sP9TMOwG/bNaFUqeCdK7Xm0zVKggfXWBWmlicJbr7zGff64FfDpt2xHeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=PAZcnNUn;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="UF6Dopc/";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3535606BDA8;
	Fri, 13 Nov 2026 10:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3535606BDA8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=PAZcnNUn;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=UF6Dopc/
Date: Fri, 13 Nov 2026 11:55:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794567323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dVD2sgjeIdy2wIdfd/QmoCMe4rJiJI4y+gjhCqqw+84=;
	b=PAZcnNUn9q2dQQtHfk6NotT8Q5KEWCdd6Ef64+esc8uiqJvLMtL3QctPC6ujTqe3Xn5kYN
	YPtsqN1L0wIDpFlTHU9t2x6PY2X837x5kxuU7oW1QzCjfSXDj2UUXL/TIL5IWmmYCJ8DHK
	+3r2aq2QhEiWWn90EQcwp0RKGR9RRM6GoT7+Zrv/p3PTzp7RxBq+6M1qc9NpbMG+ZJMmfL
	u3DZX/Fqnz3gUs+OSJ8SHu93bGUbtfAXphCcgthxmQmAtXt1K8Y+E7AjI5Boswdg0Uqveo
	AAv9/prh4ACCpLsZQHr7kWacKePQDEg2FamoOwUPIS8FyB1Hgfc93x1vbAZjJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794567323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dVD2sgjeIdy2wIdfd/QmoCMe4rJiJI4y+gjhCqqw+84=;
	b=UF6Dopc/ixvr1b8REKTtcZtOFBk/zFRwvYDANMwBDKZCzmat0FDQCbovwqH+QJdOfts/Nn
	+xI0aamwYVls5TBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joel Fernandes <joelagnelf@nvidia.com>
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
Subject: Re: [PATCH RFC 0/7] rcutorture: Rewrite RCU priority-boost test
 around a CPU-hungry reader
Message-ID: <20261113105521.spnkuQ7u@linutronix.de>
References: <20261111213826.2035045-1-joelagnelf@nvidia.com>
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
In-Reply-To: <20261111213826.2035045-1-joelagnelf@nvidia.com>

On 2026-11-11 16:38:18 [-0500], Joel Fernandes wrote:
> Related work: Sebastian's recent series on the DL fair_server taking over RT
> throttling [1], with its RFC [2], also touches rcutorture's handling of RT
> throttling. This patch should simplify or make those patches unnecessary.

Let me look at this. If this works out then the disabling of the
fair_server becomes no longer required which would be my favorite, too.

Sebastian
