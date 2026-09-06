Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1803C4B93;
	Sun,  6 Sep 2026 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788721016; cv=none; b=sKCQH5AqOrHCUD/OFjn2p7Y1OGmJybKllKd0Y3IIEGeZSscsC1roX11TG3fAMd5rZoL/knO5eEcv27tC7ZabL5ZQ46RFwKXfR9PQ0cZBpD7R7VBsRFemwCRr+wfZETd7x/7771HlrETZibAp/5aQZApt1WTVNxuFV7l8wtfwqzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788721016; c=relaxed/simple;
	bh=V0u+jsn16s5eI9vtb1nFFWYFyLvj48fXnPOFp05Y5RU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Qtld/qqtzaakvAvT2ty9AmLaMNnhFIaaxj0iw6LyaXykw/BBTQFWYE8weBEyeBHBzWncxDtHpOJA09ZI1NdOynJ2NrY36OQVPXZ/BpHwpxR3dkihd9lDPxrM3LB2BZwS6xJujdIHdzabCyQ3C87TufCOKt1PSjcgW0V10Zii1g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Egpeiq2z; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=kuQbCm/T; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Egpeiq2z";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="kuQbCm/T"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788720990; bh=yrp75nGsoy+XImbfA/yalVT
	47WYDrTT/yas5UGmVwQ4=; b=Egpeiq2zUYSsbUmGUY+hqJI/+YGFiQWF88owDySkQvEdqQueyM
	0vTuYGGcN1pyXXv6M9G6jPmSXlQSRQbFLYXnmg+EGXQGn1HtXVvXErcR+zuP45fWmgv1Yqwj7Ik
	Cgl/CEBzDhk9IMvsW2zjJ9EXoe0AkcPfQh20stvlSaXkdGY2u2O7GeqNzoy/QaEZoLXBmyZ/WIx
	JZ6HRLl/Ang+VVYS/Cjtw0XL+lMzWFTb5twlABEcSP9ptgEAJbNZgIc07VvkE3iWWbAlyhBEGO+
	2/bGWMY1eY3KgZSE27GpFPIq03+/4Y2oh08IhHYv8opLusSlvIBN5tF7wEzcv5vz6Zw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788720990; bh=yrp75nGsoy+XImbfA/yalVT
	47WYDrTT/yas5UGmVwQ4=; b=kuQbCm/TfCXSbS7v4II+SYDYEoFPFd3POW/tBmYh7vwoPeE1c6
	8dARswM+5hH9NmY7kSaoqNRRqOAvshgImCCQ==;
Date: Sun, 06 Sep 2026 19:56:29 +0100
From: Bradley Morgan <brads@mainlining.org>
To: paulmck@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: boqun@kernel.org, frederic@kernel.org, include@grrlz.net,
 jiangshanlai@gmail.com, joelagnelf@nvidia.com, josh@joshtriplett.org,
 linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org,
 qiang.zhang@linux.dev, rcu@vger.kernel.org, rostedt@goodmis.org,
 urezki@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hazptrtorture=3A_Fix_inverte?=
 =?US-ASCII?Q?d_sleep_condition_in_do=5Fpending_kthread?=
In-Reply-To: <748b12b2-f1a3-4ed8-8c9b-86fa8d9a5926@paulmck-laptop>
References: <ed125668-a77a-41b6-9d56-46ac93a5d69c@paulmck-laptop> <9D2DEA27-B3D1-4A8B-BA57-2F5EAC920C1D@mainlining.org> <b1abee12-5a3a-4750-be37-a3157c7e2217@paulmck-laptop> <28838ba4-8618-45d0-9994-3efee251bce2@efficios.com> <748b12b2-f1a3-4ed8-8c9b-86fa8d9a5926@paulmck-laptop>
Message-ID: <179E0ECA-C65D-4480-9E4E-CFA960D55665@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 6 September 2026 19:46:50 BST, "Paul E. McKenney" <paulmck@kernel.org>
wrote:
>On Sun, Sep 06, 2026 at 09:09:53AM -0400, Mathieu Desnoyers wrote:
>> On 2026-09-05 16:40, Paul E. McKenney wrote:
>> > On Fri, Sep 04, 2026 at 06:28:45PM +0100, Bradley Morgan wrote:
>> [...]
>> > I would not say "no" to a fix for this issue:
>> > 
>> >
>https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
>> 
>> I'm not sure this URL actually points to a relevant issue ?
>
>Indeed, it does not, apologies!  Here you go:
>
>https://lore.kernel.org/all/202608130915.62b53936-lkp@intel.com/
>
>> > Once that is in place, I would be happy to put this back into -next.
>> > 
>> > At some point, we will need to get rid of the concept of wildcard
>hazard
>> > pointers, as those end up instead emulating RCU, but I don't see that
>> > as an immediate obstacle.
>> 
>> I already have the implementation which eliminates the wildcard if we
>> care about this. It was part of a previous hazptr series version.
>> 
>> Do you want me to resurrect it on top of the current series ?
>> This depends on:
>> 
>> - ptr_eq(),
>> - then use ptr_eq() to compare the loaded pointer (pre mb)
>>   with the re-loaded pointer (post-mb).
>> 
>> See:
>https://lore.kernel.org/all/20251218014531.3793471-1-mathieu.desnoyers@efficios.com/
>
>The main objection was over the content and style of the kernel-doc
>header comment, right?  I am guessing that it should be possible to
>resolve this to roughly equal disgust of all concerned.  ;-)
>
>We did make some progress on this sort of pointer issue in C++29
>this past June:
>
>https://people.kernel.org/paulmck/c-pointer-zap-and-oota-progress
>
>But the piece you need is this guy, which is still in process:
>
>https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2025/p3790r1.pdf
>
>Plus it will be some time before this reaches all the compilers used
>to build the Linux kernel, and probably even more time to reach the
>C language.  I do have pen-on-paper notes that will lead to a draft
>of the corresponding C-language working paper, but these things do not
>move quickly.
>
>So, yes, we will need something like ptr_eq() for some years to come.
>
>Back to your original question, given the fix for the above bug and
>given the current use case, I believe we can get the current series into
>mainline.  Give or take Linus's thoughts on the matter.  But either way,
>we will need a version that allows the user to avoid all wildcard use
>sooner rather than later.
>
>So having a series on top of the current one for a later merge window
>would be a very good thing!
>
>							Thanx, Paul
Can I participate in this? :)
--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
