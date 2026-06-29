Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733203D6CDD;
	Mon, 29 Jun 2026 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782721258; cv=none; b=ZEPNLSV9NLFcgsab0oMUubc09YX9TAZJ3mHSIDRxi/G8yNXZakCjTpGFWLRNCQsnvofaYrXv60cGkMS2z2TbFGXY43DEd+HSMwKV2o3h23W9GFBYYec6BtDLYHfn/40baUyaOwDMald6byige7RPApuaC08+B6L+SVnjwGlBw2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782721258; c=relaxed/simple;
	bh=kia53t9Vmn3rVHR65dB2hSoGJC+kCBm9nZndKzrlbpY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QnG8d1VISMT0Otqw9r0ERDORDgLcnBoM8gwwdpY3pexGf5MVHTtO/VZs7Y1iPYOrcxnd+o/9ZgSwVYPLWN/NCTgG/+qHmc4odyZq2ei0YAfVFvqU/d1vb0eJGTLIe981YQT6banoCFle4epLlNo0z77By6aNg2eWztVjworcogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALYdjdHR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALYdjdHR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F287B1F000E9;
	Mon, 29 Jun 2026 08:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782721257;
	bh=kia53t9Vmn3rVHR65dB2hSoGJC+kCBm9nZndKzrlbpY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=ALYdjdHREWYrGGiSraB7MR+uJIezD9H8RD62KChSKPY5qxgXGXnNPOmA0XJMurrdl
	 AkcvDW58TEZEpP1VIafI87KjnUhZDr6+wuOVo8M2U+CPKAURCoIRpcaz0eUU0pIy+x
	 Nr5nn+rpu7fQ2EyjOORAw0sP6LIEf5fSon8WkphyJmSJCzTWa+2f7PMN3A1rKTklKR
	 7tfSSATNMl2tmIcJh72y3vqvLxCEGX/i3vIpmOHpyUcauAEPrMJVSHvsuJAAoFlyg8
	 ZHcQH4W7mHA01/DLNoviNonduxaiLIX3gsV2xK9uh8cMi1ilmE4nEQTdUj32wpg4Kg
	 1Fn3sX7B19hVw==
Message-ID: <b48c8045-2297-47ee-a0f7-d7a67e74ea09@kernel.org>
Date: Mon, 29 Jun 2026 17:20:46 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 2/9] mm/slab, slub_kunit: register kprobe to
 trigger _nolock APIs
From: Harry Yoo <harry@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Vlastimil Babka <vbabka@kernel.org>,
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
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 rcu@vger.kernel.org, bpf@vger.kernel.org
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-2-70a54f3775bb@kernel.org>
 <ajvczSpMOGWFhe30@pedro-suse>
 <6edebc2b-5f5a-4b9c-9a4c-564310acee1b@kernel.org>
Content-Language: en-US
In-Reply-To: <6edebc2b-5f5a-4b9c-9a4c-564310acee1b@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------8xQSbLfkLa3QcHTEy0A3WfM5"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------8xQSbLfkLa3QcHTEy0A3WfM5
Content-Type: multipart/mixed; boundary="------------H7l0hVTepAgAY5a6Xn02vj04";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Vlastimil Babka <vbabka@kernel.org>,
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
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 rcu@vger.kernel.org, bpf@vger.kernel.org
Message-ID: <b48c8045-2297-47ee-a0f7-d7a67e74ea09@kernel.org>
Subject: Re: [PATCH for-next v3 2/9] mm/slab, slub_kunit: register kprobe to
 trigger _nolock APIs
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-2-70a54f3775bb@kernel.org>
 <ajvczSpMOGWFhe30@pedro-suse>
 <6edebc2b-5f5a-4b9c-9a4c-564310acee1b@kernel.org>
In-Reply-To: <6edebc2b-5f5a-4b9c-9a4c-564310acee1b@kernel.org>

--------------H7l0hVTepAgAY5a6Xn02vj04
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/29/26 4:34 PM, Harry Yoo wrote:
>=20
>=20
> On 6/24/26 10:41 PM, Pedro Falcato wrote:
>> On Mon, Jun 15, 2026 at 08:05:56PM +0900, Harry Yoo (Oracle) wrote:
>>> Since kmalloc_nolock() always fails in NMI and hardirq contexts on
>>> PREEMPT_RT, slub_kunit cannot properly test _nolock() APIs.
>>>
>>> Register a kprobe pre-handler to invoke kmalloc_nolock() and
>>> kfree_nolock() in the middle of the slab allocator. However, do not
>>> register the handler on UP kernels [1].
>>
>> Maybe explain in the commit message why that is?
>=20
> Because it's the case is broken on UP and we decided not bother to fix.=

> Thought the cover letter in Link: would give enough context.

But I will clarify this on the commit message, thanks!

--=20
Cheers,
Harry / Hyeonggon


--------------H7l0hVTepAgAY5a6Xn02vj04--

--------------8xQSbLfkLa3QcHTEy0A3WfM5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCakIq3gAKCRCGXBN6rc5S
1oI0AQCmD4+FAnCL5s0WuOSoFo5XR/5TKwqVhP08qfsAyrwXvwD/RJBmV5okisfF
oBc6p+YW15g8jrEgvQwjI3qwgz+UDgw=
=v2D6
-----END PGP SIGNATURE-----

--------------8xQSbLfkLa3QcHTEy0A3WfM5--
