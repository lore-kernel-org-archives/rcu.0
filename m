Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A8639A803;
	Wed, 23 Sep 2026 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182029; cv=none; b=OjeCgXjPfGN/taVOt6Gz6fiua55Itr6HU6rc11hwSESSblyBBCtFQqMiC4mopHpe5Cioa6HNFS336pen8/goumRH/8y4kJMYnynwxDGAHPQkkR/rMj5ZffrogdsJg0tPOCdzKu244cnJaBHVFk2XcjUn6fmDhn247QauVsxz7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182029; c=relaxed/simple;
	bh=rN8RmioOSsIyLTDBBJuw1n9QvcUwNcKWeqX63UCbAW0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=rEGlv501qXpmuxUEDdKVqRQgKyZAz9L2zXbcBLJz802ES+Qkx8MNxBEoC9T8qzXT5mQUK3a0hYGVxUbvuq+5dYR7ZgzytctTQ6dbG1d3ZYdIU3nG3Lu9cVDvx0RgocnBZzV+HAZd6wbtStiqLrCL9XK8dyuzUsWe2FaNYI5X9dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bxejY7O1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bxejY7O1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=rN8RmioOSsIyLTDBBJuw1n9QvcUwNcKWeqX63UCbAW0=; b=bxejY7O1iRebOW7oN0FbM8ypoL
	CdWPmAHwylfBfvuzKfPN855CIk/55gDmym8CtT6Gk0XfKNdqSAk/XzkelBFBEQY7xs6XAwIp6VF6d
	oAbEV4c36dvhXTuRESfp3r8RuGoMt62yDHezeadPceyUnpF1MbjwZTgf/GIzv+hzGybr2bF3iBMPi
	eUbTTVmMK5rDpt3YX+m8+kIVrI2RnFIR+I/LlY2xsalhhDLcAWW2XDm93ReaxfYqVOphQm225N2D7
	lz09rAgg+lhFZ5cEaNBfJrawGAMmBpoTKOQ85Z8LoB6Xo9jVP0Gc5tB3qdXTF8G4mOEMOdkGUmOX2
	HQF65fyg==;
Received: from cust-west-par-46-193-9-67.cust.wifirst.net ([46.193.9.67] helo=ehlo.thunderbird.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x9Q7J-0000000F2SZ-3ykR;
	Wed, 23 Sep 2026 16:46:46 +0000
Date: Wed, 23 Sep 2026 18:46:47 +0200
From: David Woodhouse <dwmw2@infradead.org>
To: KunWu Chan <kunwu.chan@gmail.com>
CC: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 pbonzini@redhat.com, seanjc@google.com, paul@xen.org, paulmck@kernel.org,
 kunwu.chan@linux.dev, nh-open-source@amazon.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_00/17=5D_KVM=3A_Use_atomic_SRCU_for_gfn-t?=
 =?US-ASCII?Q?o-pfn_cache=2C_reinstate_guest_mode_for_x86_nesting?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAN_Opa-xVAzFAJVU3rwCsiBzVpQYqUYWzgpBBP7EaX3K+ASk1g@mail.gmail.com>
References: <20260923095435.591542-1-kunwu.chan@gmail.com> <7efbc8e2ecbf397fc8e44327d13e9a7021b97212.camel@infradead.org> <CAN_Opa-tDcZOEk=Mt5MAqUTkg2as5G79uBkxkUaJif8b5QpXYQ@mail.gmail.com> <1cb9c1d40f246ddbe24c9fb930d6dce16aaa25a1.camel@infradead.org> <CAN_Opa-xVAzFAJVU3rwCsiBzVpQYqUYWzgpBBP7EaX3K+ASk1g@mail.gmail.com>
Message-ID: <19595BD7-98B3-46F0-8B47-DAFF304C5A7A@infradead.org>
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

On 23 September 2026 18:26:32 CEST, KunWu Chan <kunwu=2Echan@gmail=2Ecom> w=
rote:
>On Thu, Sep 24, 2026 at 12:07=E2=80=AFAM David Woodhouse <dwmw2@infradead=
=2Eorg> wrote:
>>
>> On Wed, 2026-09-23 at 23:58 +0800, KunWu Chan wrote:
>> >
>> > You mentioned that the SRCU read side scales a lot better and avoids
>> > cacheline bouncing=2E If you happen to have any existing measurements=
 of
>> > the reader side, such as throughput or reader-side latency, I would b=
e
>> > very interested in seeing them=2E That would be useful for understand=
ing
>> > the reader-side benefit you mentioned=2E
>> >
>> > Of course, no need to rerun anything just for this=2E I was mainly
>> > wondering whether you already had such data from the existing testing=
=2E
>>
>> Most of the KVM gfn-to-pfn-cache usage is per-vCPU so doesn't get much
>> parallelism=2E The main case is interrupt delivery to Xen guests' event
>> channels, and I did some benchmarking of parallel interrupt delivery=2E
>> I'll see if I still have those results, or tell my friend to go and
>> repeat some meaningful tests=2E
>
>Thanks David, that would be very helpful=2E
>
>The parallel interrupt delivery case sounds particularly interesting=2E
>Please don't go to any trouble if the old results are not available=2E
>I really appreciate you checking, and I also appreciate your friend's
>help with the measurements=2E

It's no trouble; my friend is remarkably compliant once I've held its meth=
odology to account and probed at its conclusions=2E

