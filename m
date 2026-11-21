Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795274208;
	b=A+pTZlof4JtqXcgDHUNIvBj6wl1sL4Yy4CWh0b93RSCt3UZgE2ixvWuOlpMSK5WuHdtb
	 Q3gvFlkEbA/VLwvpVrp7InENZNDCl7qps+KTuK4eJQBzutcgCqJ71luaHTIEEdLJLLR0G
	 q5RgORwoKATSCUwp3usIUl5AltUEPIKMEZbILBgJ59IlCGFuBkyd/Pf3pOCS+fD04c44A
	 xWXlR7azRfn2h3LICxnjNeLzGenPEieKGO1JNLFM5xFFj5OaMHxKKXCt1aANMDbPXhAG3
	 rBKs3x0vmzyxHWVzc/sPlf7LvY/QEAvJeRMcNukA1ebUpvdkjHtf3FSnearX7xJk7/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795274208;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tXcxmgK5XTeg5jl8OuMoLjosKYF3OdoJPe6rTIZj90E=;
	b=X+OsOrm5jg503tmgXJRmNk27gdKDtjHSG3nGwGKGBNRqXSZkF+XrrUxX9HgFsmLrVJxD
	 N1E+/bG4PjqU0277oPyo/jAxzVQWuQOijuaMRHH0ofVO/DpA9cxr9ikp5cU93Qyd3LzGS
	 vkVLwPiq+re1cwao58dg31NHj5l/kQA7A9npEXACAyFF59azEJX+jLwMTAHis3Nrp4nvD
	 NF0jEz7W5VAA8O2K8dfapxanSqLTbL2xf6784PTdDdrFjzefuOYNg5749I0hc/PJGWhTg
	 BxCkWvXmn1wuZ8gW42kfw/b6RrgIwtrbprIfY8F0f0wbMnJR95EULek4XWqFEcZsCVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlElkI6B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A1EC2606A32A;
	Sat, 21 Nov 2026 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlElkI6B
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BCA341F000C6;
	Sat, 21 Nov 2026 15:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795274208;
	bh=tXcxmgK5XTeg5jl8OuMoLjosKYF3OdoJPe6rTIZj90E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HlElkI6BEmKTo0cvGYXEVmsPeAzIJjSdHof9YSUEK+DZo3Amj/oW+HHchCXYdfdWL
	 90FBkwJQljSEUv1KAcHmDq7J7HpOnOnJxQSjUUoljzAjtEGm7XWipZhaRi/HgWmKnu
	 JeYtoLrOIRGH5r6vBSCvizI2iCsvduo2Zgmg0l5gtCSQQe1OYUqQiWycTMPiKbkwKh
	 ICDpZJiHWj8daU2cM1GZM7ycnL5vExoN3bGP3GIzz1V95tcMIKWo/rU/VjlySQxmvq
	 thgVrGl8t259UdX7olBTovIFj4tPk8lk/QORJphNPMPJGq13Wisd05NKg1b8MbyHnX
	 V2CGL5j3MtKPw==
Date: Sat, 21 Nov 2026 10:16:46 -0500
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
Subject: Re: [PATCH v2 5/7] rcu: Add rcutree.boost_disable to disable
 priority boosting at runtime
Message-ID: <20261121151646.GD946893@joelbox>
References: <20261116194438.306618-1-jfern@kernel.org>
 <20261116194438.306618-6-jfern@kernel.org>
 <20261119094545.rDWiSb98@linutronix.de>
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
In-Reply-To: <20261119094545.rDWiSb98@linutronix.de>

On Thu, 19 Nov 2026, Sebastian Andrzej Siewior wrote:

> -	if (!rnp->boost_kthread_task ||
> +	if (boost_disable || !rnp->boost_kthread_task ||

> What about not deploying the boost thread as suggested in
> 	https://lore.kernel.org/all/20261113163647.OrW62pCV@linutronix.de/
>
> You would have one condition less to check for. Then it depends if you
> want this limited to testing or also allow in production.

Good point, and sorry that I did not pick this up from your first review.
I am ok with restricting it to testing, I will do it for v3.

thanks,

Joel Fernandes

