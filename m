Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C88344D91;
	Mon, 29 Jun 2026 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718479; cv=none; b=uG9FK0V2wu34btZUvYYgS/sYnzUGq34yC7l/UMd1+gvgK+wCY9bfBVOCJVuPPcMxuU38Rrfvk2r+cOiDk7s03JrMkDGJhoSuJeQwvhyjbyy7iT0Zr5SHDyOhCvn0Jw5757jjEXJ6X1lz2n6sSNFba++5rx66/9PNNcM/7HbrgHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718479; c=relaxed/simple;
	bh=HeoF2K+Kz6f/HgMEPg1+iANT1j637vPpQHoopCUQ+q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwx1S+jPVwdJhfzNqHHB1LM5I92qXzCUcTVbYESllGLU+/C8j/re8wcoBA+gF8EYn6ZUFOHUns8H9MUICPh2Uk5mp8NDk8w0uLynFP89Hf8RGEgB+AgCy4rz+pl5k6a1STwN6VN0bqX/rvb1Yc281MLCfkbGR3cddiapUp+9nwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C453Z33V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C453Z33V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DF21F000E9;
	Mon, 29 Jun 2026 07:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782718474;
	bh=HeoF2K+Kz6f/HgMEPg1+iANT1j637vPpQHoopCUQ+q0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=C453Z33VpFiMQqfQLryj2TsR8w8h3q8S2KzljnlCANMYrPh2xa5pjxvaGXhIdGng6
	 0qP2G7k5u+RtkdH3sN2KFAtAUiQHpFNmauUE6YythfPamyTeBMFE6xuq00Ew9z0lO2
	 EfXHH7b/vvwHjEwb9/hW3PHgnVSIWB91TBxolyVfFha6JB8qNlmNPJyOq4tCYOJNs5
	 Q0uo6vOb3jiqzaNiuMbVmWNeKJJgXQQsVPxDanztYI1zHuA37RpPRJNeaIbHHlfjR+
	 NHD1EiEz/u3BtR8HraMX0Y1A74Vh26oK8ytY/WHAwwmyDKPl3VBya/CEveOYKRJAtH
	 ZAPBHttxuZ55Q==
Message-ID: <6edebc2b-5f5a-4b9c-9a4c-564310acee1b@kernel.org>
Date: Mon, 29 Jun 2026 16:34:23 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 2/9] mm/slab, slub_kunit: register kprobe to
 trigger _nolock APIs
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
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <ajvczSpMOGWFhe30@pedro-suse>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------LonvLfJHVvQ11VwztTHqXi0t"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------LonvLfJHVvQ11VwztTHqXi0t
Content-Type: multipart/mixed; boundary="------------Rmq7mtq09nxsELJpSUC76Exe";
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
Message-ID: <6edebc2b-5f5a-4b9c-9a4c-564310acee1b@kernel.org>
Subject: Re: [PATCH for-next v3 2/9] mm/slab, slub_kunit: register kprobe to
 trigger _nolock APIs
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-2-70a54f3775bb@kernel.org>
 <ajvczSpMOGWFhe30@pedro-suse>
In-Reply-To: <ajvczSpMOGWFhe30@pedro-suse>

--------------Rmq7mtq09nxsELJpSUC76Exe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/24/26 10:41 PM, Pedro Falcato wrote:
> On Mon, Jun 15, 2026 at 08:05:56PM +0900, Harry Yoo (Oracle) wrote:
>> Since kmalloc_nolock() always fails in NMI and hardirq contexts on
>> PREEMPT_RT, slub_kunit cannot properly test _nolock() APIs.
>>
>> Register a kprobe pre-handler to invoke kmalloc_nolock() and
>> kfree_nolock() in the middle of the slab allocator. However, do not
>> register the handler on UP kernels [1].
>=20
> Maybe explain in the commit message why that is?

Because it's the case is broken on UP and we decided not bother to fix.
Thought the cover letter in Link: would give enough context.

>> To attach the pre-handler while s->cpu_sheaves->lock or n->list_lock
>> is held, add a wrapper function for lockdep_assert_held() that calls
>> a no-op function slab_attach_kprobe_locked() on debug builds. The
>=20
> Why lockdep?

I wanted to avoid hard-coding internal slab function names
in the test module while having a good coverage.

> Wouldn't it make more sense to add these triggers after> locking these =
locks?

Good point.

Perhaps it'd make more sense to let _trylock() fail occasionally,
because that what I actually want to test.

>> function is optimized away when neither CONFIG_PROVE_LOCKING nor
>> CONFIG_DEBUG_VM is selected and register_kprobe() fails.
>>
>> The function calls barrier() to prevent the compiler from optimizing
>> away its callsites. Otherwise, the compiler may consider the function
>> does not have any side effect and remove callsites.
>=20
> My wider comment is the following: this looks very useful but perhaps s=
hould
> be lifted to Kunit itself? There's already function redirection (which =
could
> be used for this as well).

TIL kunit function redirection, thanks :)

> I don't know if that suits your purposes?

Hmm, but looking at the kunit function redirection,
apparently the function needs to have a symbol to redirect.

Not sure how feasible it is to make all those lock helpers have symbols
to use kunit function redirection.

> Choosing to say "I want to hook this random function using kprobe and g=
ive
> it custom behavior" sounds lovely for all sorts of testing.

Sounds lovely.

Actually, I was thinking it would be lovely to have fault-injection-like
feature for memcg because it's hard to trigger that in kunit...

Thanks!

--=20
Cheers,
Harry / Hyeonggon

--------------Rmq7mtq09nxsELJpSUC76Exe--

--------------LonvLfJHVvQ11VwztTHqXi0t
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCakIf/wAKCRCGXBN6rc5S
1k2zAP0WFF+pvp88rmpHr5+CTNLJsoe3HtwPQMCjNUTN1Wuj6AD/TWU08aQXbB1M
c2AKbPtfWlxkJ3yFMUn/T9WJ1h0e9AQ=
=M28/
-----END PGP SIGNATURE-----

--------------LonvLfJHVvQ11VwztTHqXi0t--
