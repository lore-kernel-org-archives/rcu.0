Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795274290;
	b=jBW374bHB5BaYIp3wG0TtxbxI7pEmeG1HixbKert8SnnUBzzPKcmlqfGIRMHW3zuWmbM
	 RSvLiCYf2xS3VvOzxnc0X4MDnqJ06hVIp3bUjRkFRV56V8wPQNS1k2vmodZ6fKgVdxxm0
	 rwUTPDNpknY+VV7v39aYa7QgJmqpBzMTdykHLoCSGR1gYN2nn7CcdU3jzlly5saEQ1+DK
	 tQSlPollDcNHqLscVZe/eoXaM+ZFNkfeaDHTYSxh3GeHCc94zQNOAIs4N4LawckaMmqgx
	 gugTSgjrw9yb8Cn5Arn6qaMX0bGjNjVqNV72MFpvujQsUlygzdpDtKx3eZL+tW0W5Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795274290;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lpyBJkRJiIJr205Bfkql98a8CRWhfrzMz+lDyWGqmaw=;
	b=s5UwmaslFOtyOLMAsgjL4Fu21JMAOzRHuDeeXXWo4WTYMzr6AZKlZMWP+Z5mdSrDCVgi
	 ozaxK6/CusEHaUQpxKjj1SC0h1u0/N5uXWFthTCbmRpkrTyYnIvzwyq3zrdzDO4ZOSDCI
	 Z0PvkmZlTDqrrYuGsOamTzHaZ+a1j/l4H7hMcClgISfIlH8SKnyBFgBpQi0UF+C+CgX+W
	 uFivhKoupgstIqR3o7KJjqIxOYyGuN1vwUgM6sJHyHO61PuuFJGDsDyjmkRQiYnc5O950
	 AgvVp5gBj0uzsHBnl9MMdw12kSXOCSKizctmi+NDrV3UYzo1M4reQ/KuSV5ZokfB3vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SN9Dut1M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A2272606A320;
	Sat, 21 Nov 2026 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SN9Dut1M
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id AAF631F000C0;
	Sat, 21 Nov 2026 15:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795274290;
	bh=lpyBJkRJiIJr205Bfkql98a8CRWhfrzMz+lDyWGqmaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SN9Dut1MoV1fQKwGsUUx+XwAvln+8ptxGALPfOO1oKemkr19moP1TTOJo+2dyCMXB
	 gL3WDFEfoRKOqexU74KafxyuF9GJXqYaJgYJj9U4Hdo0WSNPFictjCiDB9M3NGSwWM
	 zov6shixwiXBrqYJmHO2iWVOakrGtJGK/UDbN3GHxOVhUk59I/VcoXpkMLz/6kBD8N
	 OQfM8SuUtLCfx5jfYOpvFrmfdLTUSWM68kixxZxZ/IoGxsD9OH3YQZSvRSFxUBlAQe
	 6cvH0F0Ax3zWVBwWMtdbvViZj0KW42cwrWhF5qKw9jURSqnGCjbc8hE+hzBawd7Hcs
	 7T4TssCfIBjpA==
Date: Sat, 21 Nov 2026 10:18:08 -0500
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
Subject: Re: [PATCH v2 6/7] doc: Document rcutree.boost_disable
Message-ID: <20261121151808.GE946893@joelbox>
References: <20261116194438.306618-1-jfern@kernel.org>
 <20261116194438.306618-7-jfern@kernel.org>
 <20261119094802.qh6UUaw8@linutronix.de>
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
In-Reply-To: <20261119094802.qh6UUaw8@linutronix.de>

On Thu, 19 Nov 2026, Sebastian Andrzej Siewior wrote:

> If you intend that both changes (adding boost_disable and its
> documentation) are merged via one tree, why do you split it in two
> patches?

There is no good reason, both go through the RCU tree. I will fold the
documentation into the code patch in v3.

> If so, why not limit it to the test-module?

And yes, I will limit it to rcutorture, as described in my reply to 5/7. Thanks!


thanks,

Joel Fernandes

