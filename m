Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20892EC090;
	Sun,  6 Sep 2026 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788700919; cv=none; b=H3xK0zkhmMHnN45WZ2FNRWmskp0Sojz6Q3hqtbMPWo1lcQmIwjZeu0ZcKU20LFKCQTkxbriHcnieU0yGqTevdBplQHgeC33zdaQxASktJ0ASpCS7Bk9M440iB+NDSMVFRCOFpuxLMPABcN7EUKM16k015GrkD/8KArjG+mgeEnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788700919; c=relaxed/simple;
	bh=j8bgUiBDfs14cPtSE/+qh0l5jOu2NKMv/PNUHR2OSOU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=GOOKwNkn4lQjct4Om+pMF61Np/p8r8wtyYlK6GyVerd/UXqAQXHwo5FWMk9c9KPCUlEKSl0TPA7Kv4E/aFgqrATmDL8o+CvgNb7U681XX/io7BkTfFpdAGKBAyxSTXJnWPws0hbiu9060TEyK0U6Teg6lxysmT1W1iAuHGY3cao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=gEn7I1PJ; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=rjLyAaDo; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="gEn7I1PJ";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="rjLyAaDo"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788700898; bh=N637vZAKentMSv1ZC/QWT5P
	1ZUk/by7OOpX3tsSZoRQ=; b=gEn7I1PJJ/w4v9ydyTp7vd8LvTvP0OS1h/XneEIAvbYL0/6z9H
	JNevONnm4z3oFyRaxxsd2VbAXOf5DMvMBA0C7aGFgnvbHcIhDzmSixntcGRMVmiQRoNp8Kh9l79
	Gv65J0FEz6Mzw0Rp3F29R2TB8/8JwGzoyMgd2DQOHmFbZEQWgwgwZf8YnZIe0HolnUhiRa15ZR5
	Bnye2DcqnVaIQW+mzACnF/ssCixAXQr9TZFc8hAr9fNyXpls1ez3ogobiXtrNIGW5iByI3shLNR
	8AK2tdv83w5kB+XXZ7sRWs7YBcLDiGSXI/nrbMPX2dd5Em3ke/GLfGcU+xT5JSf1tXQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788700898; bh=N637vZAKentMSv1ZC/QWT5P
	1ZUk/by7OOpX3tsSZoRQ=; b=rjLyAaDokUtUGM5l5GQBoxUFlcjSBBt9oYVSjfqpqdQDIgfODp
	3+sb02KCnebNelw4Yt1noWU0eVFiQCFB9jBg==;
Date: Sun, 06 Sep 2026 14:21:34 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, paulmck@kernel.org
CC: boqun@kernel.org, frederic@kernel.org, include@grrlz.net,
 jiangshanlai@gmail.com, joelagnelf@nvidia.com, josh@joshtriplett.org,
 linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org,
 qiang.zhang@linux.dev, rcu@vger.kernel.org, rostedt@goodmis.org,
 urezki@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hazptrtorture=3A_Fix_inverte?=
 =?US-ASCII?Q?d_sleep_condition_in_do=5Fpending_kthread?=
In-Reply-To: <7F7990FA-258E-488B-B291-31570C4F70C7@mainlining.org>
References: <ed125668-a77a-41b6-9d56-46ac93a5d69c@paulmck-laptop> <9D2DEA27-B3D1-4A8B-BA57-2F5EAC920C1D@mainlining.org> <b1abee12-5a3a-4750-be37-a3157c7e2217@paulmck-laptop> <28838ba4-8618-45d0-9994-3efee251bce2@efficios.com> <7F7990FA-258E-488B-B291-31570C4F70C7@mainlining.org>
Message-ID: <66B55D18-B743-4CDD-BB0B-7F8F1BD98607@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 6 September 2026 14:20:59 BST, Bradley Morgan <brads@mainlining.org>
wrote:
>On 6 September 2026 14:09:53 BST, Mathieu Desnoyers
><mathieu.desnoyers@efficios.com> wrote:
>>On 2026-09-05 16:40, Paul E. McKenney wrote:
>>> On Fri, Sep 04, 2026 at 06:28:45PM +0100, Bradley Morgan wrote:
>>[...]
>>> I would not say "no" to a fix for this issue:
>>> 
>>>
>>https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
>>
>>I'm not sure this URL actually points to a relevant issue ?
>>
>
>No, that URL is my signature, just in case people
>
>1: add my old email to R-Bs, or SOBs.
>
>2: makes people aware this is me.
>
>>> 
>>> Once that is in place, I would be happy to put this back into -next.
>>> 
>>> At some point, we will need to get rid of the concept of wildcard
>hazard
>>> pointers, as those end up instead emulating RCU, but I don't see that
>>> as an immediate obstacle.
>>
>>I already have the implementation which eliminates the wildcard if we
>>care about this. It was part of a previous hazptr series version.
>>
>>Do you want me to resurrect it on top of the current series ?
>>This depends on:
>>
>>- ptr_eq(),
>>- then use ptr_eq() to compare the loaded pointer (pre mb)
>>  with the re-loaded pointer (post-mb).
>>

Sure, I can help write it if you want

>>See:
>https://lore.kernel.org/all/20251218014531.3793471-1-mathieu.desnoyers@efficios.com/
>>
>>Thanks,
>>
>>Mathieu
>>
>>
>
>--- Thanks!
>https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
