Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925862F7F18;
	Sun, 17 May 2026 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779045083; cv=none; b=UI/a7rjfdhv0GTAvydO8I3SDZxb/jktBTdAe9V8AtJ3BvXlDgH0vK89OjODX5uqUcHZ18mYGP42eNPpPXa4kIviADRIUMnc3MYksDjZ8JuU5y5zsJTrZNO//saskmfDAohNc3imL0MAMTUy+hQ84Xv6EAsq+0Wn48z21SmIZFcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779045083; c=relaxed/simple;
	bh=+C8rTZmipfMsFJX06yKaIGuUqEKIfJYQEZDkBdIi/LQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDOvqTYXE+Lh52o8aDEUHNlMKwp8Db8+P8CkK6id1jP3TLGyJsSuhdILJ7kHh5nuexOLX4bOAP/Ge1oBEkkYw1DuIJhFGpBTUaGKE01irNxEJ3dVLa7/1uNlNEfZdvCAOlBWyS9oMA3FwuxFwAN4ZznyT4g0D2y1XOUoo4sxKsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=HW16H/yb; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="HW16H/yb"
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gJVsF23xZz4Cl8;
	Sun, 17 May 2026 21:11:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1779045073;
	bh=+C8rTZmipfMsFJX06yKaIGuUqEKIfJYQEZDkBdIi/LQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HW16H/ybkGoztcEqTv8wnj2ZGdbrL1Qb227YPhdmEwbbBdzdA4FQhmVhjKXvpe5WN
	 5QhXw7a3p3RZQ//wMOLcRX65blHkDaDab3HPDRgCQeESoK16ZjBML2ouhvJxDFsR0e
	 ajBkjYYS0s2ahTdTpLVpZqpMZp7IA8Fu6TCKJ+3NRqMM35AS7F48HpXzQt0Rw8Um5G
	 fy3C9PdTp9iQsuV5uApIXsEYyDxV7c6CgaqmdmsG7oozBPpNUA6uz8DSvZHcLeEdfY
	 UBbvJF+cVyaVsWFIRZME3BfD1WWi/O45PPZ6RCNQAwkNLuy43tzRHUUxQUFyNxOcFs
	 33Gj2Z9vmjS6w==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gJVsF1LKZz7wmx;
	Sun, 17 May 2026 21:11:13 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gJVsD50nMz8sWT;
	Sun, 17 May 2026 21:11:12 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id A13CC6183A;
	Sun, 17 May 2026 21:11:11 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <53d546e4-8db0-4e14-a79d-270212081be7@leemhuis.info>
Date: Sun, 17 May 2026 21:11:10 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v1 05/12] srcu: Don't queue workqueue handlers to
 never-online CPUs
To: paulmck@kernel.org, Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes
 <joelagnelf@nvidia.com>, RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Frederic Weisbecker <frederic@kernel.org>, Samir <samir@linux.ibm.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Tejun Heo <tj@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Jiri Slaby <jirislaby@kernel.org>
References: <20260511175448.153326-1-urezki@gmail.com>
 <20260511175448.153326-6-urezki@gmail.com>
 <f669fbc9-c068-489f-bd91-4e81561a6e58@leemhuis.info> <agm4-6f-6rOgQPFB@pc636>
 <3dd5cce0-51f9-4cf1-81b8-246e6c6a633a@paulmck-laptop>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <3dd5cce0-51f9-4cf1-81b8-246e6c6a633a@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177904507216.374758.14252442133066974404@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: A13CC6183A
X-NC-CID: YWPj/a661c0nGoB1Peu0hN2b3oB9Vwn8GYRRVfB+Qq0nG+VjdlQ=

On 5/17/26 20:03, Paul E. McKenney wrote:
> On Sun, May 17, 2026 at 02:47:55PM +0200, Uladzislau Rezki wrote:
>> On Wed, May 13, 2026 at 12:38:01PM +0200, Thorsten Leemhuis wrote:
>>> On 5/11/26 19:54, Uladzislau Rezki (Sony) wrote:
>>>> From: "Paul E. McKenney" <paulmck@kernel.org>
>>>>
>>>> While an srcu_struct structure is in the midst of switching from CPU-0
>>>> to all-CPUs state, it can attempt to invoke callbacks for CPUs that
>>>> have never been online.  Worse yet, it can attempt in invoke callbacks
>>>> for CPUs that never will be online, even including imaginary CPUs not in
>>>> cpu_possible_mask.  This can cause hangs on s390,
>>>
>>> Uladzislau, Paul, according to the fixes tag below this change fixes a
>>> change that went into 7.0-rc6 -- and apparently causes a "hang" on some
>>> architectures. So shouldn't this be heading to mainline instead of
>>> -next? Ideally with a stable tag to ensure backporting to 7.0.y, but
>>> that is a separate decision?
>>>
>> I assume it will be picked to stable

Thx for the reply. This answered the second aspect I raised. What about
the first: shouldn't this be heading to mainline this cycle, ideally
quite soon? Or is this the plan and I misinterpreted the "-next" in the
subject?

Sadly Jiri (now CCed) afaics didn't yet report if this fix helped to fix
the issues they were seeing, but it sounded a lot like it was likely:
https://lore.kernel.org/all/f0351414-41af-4f74-899c-87fb5bb45621@kernel.org/

>> since there is a "Fixes:" tag. From
>> the other hand i can explicitly update commit message with Cc: stable@vger.kernel.org
>>
>> Paul, any thoughts?
> 
> The "Fixes" tag should cover it.

Often it does, yes, but it might be silently dropped for one reason or
another. So in the end only a stable tag will guarantee backporting
attempt by the stable team.

Site note: I recently also tried to persuade Greg to also take those
with a stable tag first in case there is a huge backlog.

Ciao, Thorsten
