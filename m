Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937C04502F;
	Sun,  9 Aug 2026 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786299103; cv=none; b=O7m1dE0W0O94IstR2434LMWEFpr79oLfU1GNM4T4PE4BjUcgAy/l+wjCihsfLtW5NhTbv+EOoyDWyPARhkjHKxgStdPqaRhowqVocjjuu9gCyOki78EYUIF7A22aEMRfLMX6NQGUsWr5vNcuexcZ60Qejx/SRjQyi9NTjR5Ly1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786299103; c=relaxed/simple;
	bh=CH7UPsLHY0pWd1s6wlA8t/Cm/C5n0GbvKLfn4FZ7sbw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=G2W9Cw7+lqUryvqilAfPe+FSBnI+ZjCVeG1cGtichQVICRj/6sfnIj4Uj3wZL4SgaBsDKUcAsmcOgQnuC2w2/95d5KPJvCV5rCE4DT937QQnPZC8h9e5SibYkQRg8jHkA4PUeyj40n6tiRft2nvJHvr0NPHFPj1Ppj/UEEiWIYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C9Jc9mWK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C9Jc9mWK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=O0QZ3aXC/1kjWuBIitMbAGKYr70nX2jxTSgfDwQYyL8=; b=C9Jc9mWKcSsqBbUh4f9k3kfmI2
	434R/JxJOOepRcBHQU+WEeCyRJ16NbPJvtI5XmFx9qZzWq4injgW8Gebw94d4I33Ey1bEWwnnNfhi
	q7z0lhDcyoGx+kByj9uzTYpPkAiaas5jGnKuJDlemOL7XymwhDGBC4KTG8D7ql5NHzl0z8HRWzn/A
	nzyYcBpB56Fhb7NIY1K00t274EUAVWtZ/szs9hJfYqYOrbXot6jjmqGiukAqkxlW86hLamDaEZyE7
	7JHQjaVJI0gwW9jRtvTRsGQZ4vFDRdu97eYyW9JAsAnKJlCt/AsoFu0LrqX/hlLeYIVKczoDqhGee
	k3yuSM0g==;
Received: from [213.121.138.27] (helo=ehlo.thunderbird.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wt7b3-0000000DLls-2sM6;
	Sun, 09 Aug 2026 17:46:06 +0000
Date: Sun, 09 Aug 2026 18:44:55 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Uladzislau Rezki <urezki@gmail.com>
CC: paulmck@kernel.org, Sean Christopherson <seanjc@google.com>,
 Boqun Feng <boqun@kernel.org>, kvm@vger.kernel.org, rcu@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_3/7=5D_KVM=3A_pfncache=3A_Us?=
 =?US-ASCII?Q?e_RCU_for_readers_instead_of_a_rwlock?=
User-Agent: K-9 Mail for Android
In-Reply-To: <anibnhTYdwdn51FF@milan>
References: <0d483855-4d2f-4502-858c-c88077aa0b94@paulmck-laptop> <d0fdf8aa4faa4e349cdc0e051b6e211cddd566b0.camel@infradead.org> <anibnhTYdwdn51FF@milan>
Message-ID: <54244653-0825-4F1C-8852-003762176FE3@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 9 August 2026 16:24:14 BST, Uladzislau Rezki <urezki@gmail=2Ecom> wrote:
>On Sun, Aug 09, 2026 at 10:59:59AM +0100, David Woodhouse wrote:
>> +	/*
>> +	 * Try a non-blocking allocation first, leaving the spare untouched
>> +	 * in the common no-pressure case so that it is still there when
>> +	 * there really is pressure=2E
>> +	 */
>> +	node =3D kzalloc_objs(*node, rcu_num_nodes, GFP_NOWAIT | __GFP_NOWARN=
);
>>
>GFP_NOWAIT already contains __GFP_NOWARN=2E It is odd=2E

Ack, thanks=2E Will fix in my tree=2E

>> +	if (node)
>> +		return node;
>> +
>> +	node =3D xchg(&srcu_spare_nodes, NULL);
>> +	if (node) {
>> +		schedule_work(&srcu_spare_replenish_work);
>>
>I am not sure but if there is a need in doing progress forward, probably
>separate wq with WQ_MEM_RECLAIM | WQ_UNBOUND flags is better=2E It has an
>extra rescue kthread to do the progress if no memory or high mem-pressure=
=2E

I don't think there is a *need* per se,  as all that happens is a few more=
 less efficient grace periods before the allocation finally succeeds=2E And=
 frankly, if memory pressure is that bad the efficiency of the grace period=
s is probably the least of your worries=2E
