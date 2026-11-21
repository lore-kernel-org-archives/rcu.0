Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795274372;
	b=XuJzXNDQipAYAj+2xhlVlimEvOGhnfowB74tkCJdpXonwU5wOE8ljqV9h5x6lmD2S1WC
	 U4ZlJXP13t8GHtmXnW2Q7/DrVBZYaiBqB4cXT7GDOLz8dASezPZi509W3mLgZH2tlhZEi
	 Ti7Ee8LR3fp1nwWmbgMQXJoo9h9nSIGBEvaMs+EaUiipXy0YG6UJXtzQ8oBw3LTQJvH8E
	 zWPAPOKnfClLPSzSkUS4SVjznkAqxVvohQ+53z1bn3VFzEdg9eDuOiKW739ZADcSkmeQk
	 VT5bi3KEctR+nUibaLeoET3TLqN5G146moHfmsnrmbSR8kmoU+4cR1erdt2HZsLCzCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795274372;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+Hgp1B6fD9zzppPldEIpxLhJwS4sYIDRauCENQnGnnQ=;
	b=CeSFSNQhTGvHP1M9vadlUspasElz5NrCw0R9d5z9UGfUO7u+lF6W4lysVhfXAKDuRFgK
	 +m6d/bNeNV0H0RZOjlM6daJBwz+4BwWHoVBqyqUtKpmQYn4M/l2XzMzPyWHGK/q7OVTXT
	 WdnvGajrm0tqxIL1XNKGnBn8lf6WZDYHSp3htxVEPLnZNH+STr/efqtIREifnj3KyD/PO
	 I89I45FdrJUAU7nuqK/laMvzReT6QDAS3hyTuIlA0yTIYekSSl6Y55zyYWNf4oA3q1jQZ
	 x5SJaOeaqIondXPSdEhUcE9yIi14/frXhfGo+I1EsrD0BIGzVq3cJTZZG0gQVfwBgRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFK1muRW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 92DD0606A320;
	Sat, 21 Nov 2026 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFK1muRW
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0D5851F000C4;
	Sat, 21 Nov 2026 15:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795274372;
	bh=+Hgp1B6fD9zzppPldEIpxLhJwS4sYIDRauCENQnGnnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mFK1muRWhfcZzkfZJte2Um4BVK0FOduikHND1SFLRCqn0GGmdlpYLOQBVo1JUEyHV
	 bn+aZYPqiTqgFAWWH3TiX3a2aOj1cBaqZ9bgJWMsWA8fWPDV4XlSkB2ePG/7fegl+k
	 N2UH4ljOD5CcTDAs6m1AG2cDTVMHAFF4fbqNKZ4KWzPwnxsAzeL85dwH9Ua9+8D7IF
	 U0VwsaLOJW7Idl3ocs4CnPQAlSWTbaCPhpSIdt9lfv+Uo+NZianm1OcMleE4Y0RAh3
	 NQ+HUntxXZocjYoYmBiJgqdBFrucAhZWHJKnKT6mFQsYZcDxJY0xMPnsbH5mcNb6j+
	 Jx8T4wXHZ4laA==
Date: Sat, 21 Nov 2026 10:19:31 -0500
From: Joel Fernandes <jfern@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Message-ID: <20261121151931.GF946893@joelbox>
References: <20261116194438.306618-1-jfern@kernel.org>
 <20261116194438.306618-5-jfern@kernel.org>
 <20261119093901.Gtf9Mom6@linutronix.de>
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
In-Reply-To: <20261119093901.Gtf9Mom6@linutronix.de>

On Thu, 19 Nov 2026, Sebastian Andrzej Siewior wrote:

> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks a lot for the review. I will carry your Reviewed-by into v3.

