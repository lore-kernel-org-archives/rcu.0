Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.12.242.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794245548;
	b=1cI2cKVJg5H+yb/s31vstGzMSKL1fNKhWYddGTtkt9ixLdX0WhPnI3P1vtjaYVqDPoAg
	 kNsNoJh+DztAMqpOiqw8yP0IHF3dnsnEn2duR/LL9q8C7YWY5s7lZOuiU5g6oslX8qi6Q
	 fYEjQVoMKr7CyNFrS/qxcwm1LMOfu8buCFMSQJCY/aY1+G2AlVlETe2DoDDAv3N2hG/og
	 eihFJa1jcfV4mEfJAJkj99j2CThyfk9KpBDld0RkP48xTi9ArX2ZU/5nwWpN+w2z0L4Rk
	 oqxLwiBrOjSMnQP5Bj4dR/0w0c44b1QB6czrDOkdX2MsOnVY7RNAkXhaVB49SxxZeHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245548;
	h=DMARC-Filter:Received:DKIM-Signature:X-ME-Helo:X-ME-Auth:X-ME-Date:
	 X-ME-IP:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7QL9J6CBq19v2RGmF50V0Q+Cl8oBUhK0P7ZMvBkglAI=;
	b=B/J3WiUdI8hpkoCMR4sQifPcW2rlf4JxFW31nNABkKodaopig3H1mwkDSykxgxOhnuTD
	 3afLLb2DVERQ5aFX6Tft3d7gXLHlE1rvVqVV5GJXl5jtFluD8UYjeT2fIjjUL4XdBf+iA
	 JdX4HTefgqwBZ2vPApv5ftzKTU9FnZaIKHWlGyUP1JEM++SQYh2GRG1/J/eNRrvNSVpls
	 Gtz7vnwvBH+889R2ObBQMSRBwyGpJCCXjyh1D42A08p9/yWzChWPEamwVkJ1yTy8in85l
	 tU8I8LdcVrUwwLuHCes3Vau8Jor0qBYOtaka2W9duRjF2/Lu1OGRqfgz+y8GcIPmB6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wanadoo.fr;
	spf=pass smtp.mailfrom=wanadoo.fr;
	dkim=pass header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256 header.s=t20230301 header.b=esOoyups;
	arc=none smtp.remote-ip=80.12.242.15
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80884606A332;
	Mon,  9 Nov 2026 17:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80884606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256 header.s=t20230301 header.b=esOoyups
Received: from [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
 ([IPv6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e])
	by smtp.orange.fr with ESMTPSA
	id QTE8xNlmxWwOoQTE8xiBMe; Mon, 09 Nov 2026 18:32:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1794245539;
	bh=7QL9J6CBq19v2RGmF50V0Q+Cl8oBUhK0P7ZMvBkglAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=esOoyups8EzKSSW67WCtqR9QmAwhB8YFRdPv2JTJuBSMed/1rHDWnypYoULw2/REv
	 54rLfSG8/Y8utcL4UOyEZWbgsPDEsupl/Y0kXfPAFlpr98RpEBM+dmnDAE4jQ1wGuz
	 PwNEw+KfnJDvbp4wJjoktnSxJhT9v77rDBJlreMmm+Uj42Ms5PO8NY/hP4/K4unoo9
	 vqnA5B/HHHzAs+zFxF2XIFiFghBbLdOnlbX+gSKSp94JvWEm1zWQDhoi9Hj+kSr5TS
	 nmu1r4y3H76gq9AyL/H4H0s7S7SOxRFDoIE02L1/70pIkI7nA1pLviE/W03bSMCi5j
	 qbP7IFRUzlmYw==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 09 Nov 2026 18:32:19 +0100
X-ME-IP: 2a01:cb10:785:b00:26fb:aefb:6cd2:db0e
Message-ID: <2727df26-9f09-48c9-90b5-2d1416c3b2b1@wanadoo.fr>
Date: Mon, 9 Nov 2026 18:32:15 +0100
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcuscale: Constify struct rcu_scale_ops
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, "Paul E. McKenney"
 <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 rcu@vger.kernel.org
References: <3f546f8e102ef271e7d5ac6d8b6a1f44d0fb20cb.1794085327.git.christophe.jaillet@wanadoo.fr>
 <20261108230623.GA3148953@joelbox>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <20261108230623.GA3148953@joelbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 09/11/2026 à 00:06, Joel Fernandes a écrit :
> On Sat, Nov 07, 2026 at 10:02:25PM +0100, Christophe JAILLET wrote:
>> 'struct rcu_scale_ops' is not modified in this driver.
>>
>> Constifying these structures moves some data to a read-only section, so
>> increases overall security, especially when the structure holds some
>> function pointers.
>>
>> On a x86_64, with allmodconfig:
>> Before:
>> ======
>>     text	   data	    bss	    dec	    hex	filename
>>    45585	  24946	   2816	  73347	  11e83	kernel/rcu/rcuscale.o
>>
>> After:
>> =====
>>     text	   data	    bss	    dec	    hex	filename
>>    46545	  23986	   2816	  73347	  11e83	kernel/rcu/rcuscale.o
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Compile tested only.
> 
> rcuscale is a test kernel module, is it worth adding boilerplate for
> non-production code sighting security reasons?

Oups, now I better understand Bradley Morgan comments.

I didn't notice it was a test module.
My patch makes no more sense, as it is not hardening runtime, so feel 
free to just drop it.

Sorry for the noise and not seeing it by myself.

CJ

> 
> Do you mind runtime testing it too if you still feel we should do it (and
> provide reasons why)?
> 
> thanks,
> 
> Joel Fernandes
> 
