Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD68220FA81;
	Sun,  6 Sep 2026 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788700890; cv=none; b=MC7IqRUg+1qdmTUGUFzxaZ4xa9UE+jBX1FaraTVXjk36gqVjXspMQuufSoaXc1j0OoHsWLMUUgVRgzPjRa2Z+MLkF0zCWuyhqx89DCxEVop8bviwPi2oiEaJKGD79tkFt5lx73aItm54sNaVMDBsuSMP+tv0G7R3RmjXS1dH0WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788700890; c=relaxed/simple;
	bh=JevZghghqJ9C0ONXEcRGG4k3wydfwyqkbIi3V+w9f0s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=QqxUp3kSdyzYJOw+i61mvH8day0KI4i1olew5YpmXPpQaBNXLOsqf3EdNKp9SkyaMjkIhh7IIwZEWEwFQQ98HyFwHTr1BhNbdot4fNJlMu1Ne9n06zLh9NkybDY4jcEf8dVqNCLw54OeHzmvh9qU5UTYanMTeY27HQDwDi+T87Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=ednsLN/p; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=ekTA9FZM; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="ednsLN/p";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="ekTA9FZM"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788700861; bh=S4ON8vR5rw7HOQO+TbO3ECb
	jF4LZR4BOOYyGBljsVK4=; b=ednsLN/pi7PrwTmr2tkDlSiUffh0uNoTC3C+usVWcqvkkq5U2M
	xY7xgtDAKIb3tLHZHOC2psWEoHG5ZS8Nf6A28bwWfEX8a5aU7KUdOhuRifRa83lMjSTWXsWI01T
	wDkFyxqEZhs/cPO87YUd7i4XYpmN8O5wrCsDj/81UcQ8qfowg/yg4HKGieaYTv5e8l/dH3Ey7V2
	RzEVvBPvI7Gzmno0314WafKCi8zpDPD+O04hPo2qtS/5kGqyW5AywImXNapboteCybHbROps6Ra
	UzJv5urQJF7rvhr+REj09B2wqO1kNeylriV9pk1br4uYQH7fmcSfETnclE3d9Y5H4EA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788700861; bh=S4ON8vR5rw7HOQO+TbO3ECb
	jF4LZR4BOOYyGBljsVK4=; b=ekTA9FZMR7eTknsp78hcHSVneZnnK67rgVFD1GPU5bHvGoXqmL
	1SpNdhn2//u4xw2wM+h+nIu9OG3Dz3wCW1Cw==;
Date: Sun, 06 Sep 2026 14:20:59 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, paulmck@kernel.org
CC: boqun@kernel.org, frederic@kernel.org, include@grrlz.net,
 jiangshanlai@gmail.com, joelagnelf@nvidia.com, josh@joshtriplett.org,
 linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org,
 qiang.zhang@linux.dev, rcu@vger.kernel.org, rostedt@goodmis.org,
 urezki@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hazptrtorture=3A_Fix_inverte?=
 =?US-ASCII?Q?d_sleep_condition_in_do=5Fpending_kthread?=
In-Reply-To: <28838ba4-8618-45d0-9994-3efee251bce2@efficios.com>
References: <ed125668-a77a-41b6-9d56-46ac93a5d69c@paulmck-laptop> <9D2DEA27-B3D1-4A8B-BA57-2F5EAC920C1D@mainlining.org> <b1abee12-5a3a-4750-be37-a3157c7e2217@paulmck-laptop> <28838ba4-8618-45d0-9994-3efee251bce2@efficios.com>
Message-ID: <7F7990FA-258E-488B-B291-31570C4F70C7@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 6 September 2026 14:09:53 BST, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>On 2026-09-05 16:40, Paul E. McKenney wrote:
>> On Fri, Sep 04, 2026 at 06:28:45PM +0100, Bradley Morgan wrote:
>[...]
>> I would not say "no" to a fix for this issue:
>> 
>>
>https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
>
>I'm not sure this URL actually points to a relevant issue ?
>

No, that URL is my signature, just in case people

1: add my old email to R-Bs, or SOBs.

2: makes people aware this is me.

>> 
>> Once that is in place, I would be happy to put this back into -next.
>> 
>> At some point, we will need to get rid of the concept of wildcard hazard
>> pointers, as those end up instead emulating RCU, but I don't see that
>> as an immediate obstacle.
>
>I already have the implementation which eliminates the wildcard if we
>care about this. It was part of a previous hazptr series version.
>
>Do you want me to resurrect it on top of the current series ?
>This depends on:
>
>- ptr_eq(),
>- then use ptr_eq() to compare the loaded pointer (pre mb)
>  with the re-loaded pointer (post-mb).
>
>See: https://lore.kernel.org/all/20251218014531.3793471-1-mathieu.desnoyers@efficios.com/
>
>Thanks,
>
>Mathieu
>
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
