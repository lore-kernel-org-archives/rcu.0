Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C521EEA49;
	Tue, 16 Jun 2026 05:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587434; cv=none; b=fTIn7Kc/HJzk8FdQr2veJCGdUw5dHmisnsdp8P2T9j/v9ElYg6YgN5L0iucyGT39FRArVi/fqmLZC6RVcGeiHBkfla5PuKcL41LRqJF7TSiBS+M5QBSboUPD6baPCE0mCLdDvDMaZJ+Nc64YLzKiS747jYP3zNO93uWcDR3xG9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587434; c=relaxed/simple;
	bh=QxH5qOTe/YG8RUrLabSR6EzwwhszMJWlBSsZ8Mep+KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQbxYWsC+bWlwy5IrsnyGH2P9SZZ1He4A++GEkIblW0TIwTioPLzPqzrfcsGRthwyCmXz7sRtHLfHdo0EAanKfaQ7o3Jn0wOXE/fRiHJggu1DQe+eNEJt3eJwsGwivBRHxRYEzRArd+Iv0vHf3VibONlVKugs5EujC7G8Q/dZjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kG6Aojvq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kG6Aojvq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C171F000E9;
	Tue, 16 Jun 2026 05:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781587433;
	bh=QxH5qOTe/YG8RUrLabSR6EzwwhszMJWlBSsZ8Mep+KM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kG6Aojvqf2S6KeFzC84yjhG9VPPJBAAYbiSvfpHpD23VaszvHKOoEq1AKHv7GwTXm
	 Rno48p8+6FfjRUIJn2gOhE14/u4zwiqzzhnJi6MJBBZtTJMoJyb52CYCJ0tZ238uv/
	 wZDyjBqf7GPF1gzLERDXSkItxwy8/cZCjbbyQhdRFwiWgRR8d66Tgd7KgLtlOJxEt0
	 7AtmV9S1Zxk6Dihh3DANuMrX8oyOh1Osfhlz91nfVtaM21z9vwEPdOnnBoUAsjz7BJ
	 s250yj4kdW/xFc8WMx57LqE5tduMZD0g4rXh2jFwp5CCdasx0njIzJWr0uAtuAHHzn
	 5H4saBl9Of6eA==
Message-ID: <327e2eeb-b9e4-44b8-a933-9ad783d34ed7@kernel.org>
Date: Tue, 16 Jun 2026 14:23:45 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 1/9] slub_kunit: fall back to SW perf events
 when HW PMU is not available
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, bpf@vger.kernel.org
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-1-70a54f3775bb@kernel.org>
 <DJ9W31UCKPW5.R2LKIC72ZQ68@gmail.com>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <DJ9W31UCKPW5.R2LKIC72ZQ68@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------rP7fGiX08FjSBMo4mTOXAahH"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------rP7fGiX08FjSBMo4mTOXAahH
Content-Type: multipart/mixed; boundary="------------3SbEaLSYHxVUNx3lobFuFikg";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, bpf@vger.kernel.org
Message-ID: <327e2eeb-b9e4-44b8-a933-9ad783d34ed7@kernel.org>
Subject: Re: [PATCH for-next v3 1/9] slub_kunit: fall back to SW perf events
 when HW PMU is not available
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-1-70a54f3775bb@kernel.org>
 <DJ9W31UCKPW5.R2LKIC72ZQ68@gmail.com>
In-Reply-To: <DJ9W31UCKPW5.R2LKIC72ZQ68@gmail.com>

--------------3SbEaLSYHxVUNx3lobFuFikg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/16/26 5:01 AM, Alexei Starovoitov wrote:
> On Mon Jun 15, 2026 at 4:05 AM PDT, Harry Yoo (Oracle) wrote:
>> slub_kunit uses hardware perf events to invoke _nolock() APIs from NMI=

>> context. However, creating a HW perf event fails when there is no
>> hardware PMU, or when running in a virtualized environment without a
>> virtual PMU configured.
>>
>> Since tests are often performed in virtualized environments, fall back=

>> to a SW perf event so that the test can still run, even if it cannot
>> cover IRQ-disabled sections.
>=20
> Frankly, I wouldn't bother with this fallback, since it completely miss=
es
> irq disabled section which is the one to test with *_nolock().

Right, it only covers percpu sheaves locks.

> VMs need to configured properly. Even nested VMs support
> PERF_COUNT_HW_CPU_CYCLES.

And now that even VMs that are not properly configured can test it using
kprobe with _some_ coverage, we don't really need the fallback.

Will drop the fallback.

> Also in overflow_handler_test_nolock()
> I would add
> even->hw.interrupts =3D 0;
> to the end to make sure it actually stress tests things.
> Without it NMIs are not firing quickly enough.

Will do.

Thanks!

--=20
Cheers,
Harry / Hyeonggon

--------------3SbEaLSYHxVUNx3lobFuFikg--

--------------rP7fGiX08FjSBMo4mTOXAahH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCajDd4gAKCRCGXBN6rc5S
1mG/AQD+6bsjWeb6zEOVUA7ge6HdSL9IweB0GLSChJQcA/DgyAEAmysfWrQosnQc
o3L/HYTVOn3F0X9ZEn1ONdfMyvCtdgk=
=qy9q
-----END PGP SIGNATURE-----

--------------rP7fGiX08FjSBMo4mTOXAahH--
