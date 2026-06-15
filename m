Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B1F378D63;
	Mon, 15 Jun 2026 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781528322; cv=none; b=CkcqfEl5/wZN/MlVNULLUIIlWZD60TvPwTysdbr+fwe2z2A4K3AWdLppCGr6FlfEN1KHQYwZeJlI9SLYW8FEPxkb8z7y+zDBmHVTGuUUGHZsrTyfdNajJxJyawCyq2mysxEo8P1UDIsWRNZf7DDONBjg/3LGfPL6yANPY6FJvfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781528322; c=relaxed/simple;
	bh=IM3dJKkwKyjufiuTnVdZPgRCLrPDyuQRh+tKDGzVpVw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tLp+G0EVTtnyUQr8yTT/9pvcsMz4scV8eAt8eDli8sKRUceiVAtVm1iqco+h16VfRu/NVdFFGokXsRnqgOI3QQbmCHBsSS9e/l/UjIDEjea/eQg2IfRg3o5oiLGSc9FPGKSruHE0WASLdxus+uzA3gw5qfCY1MD2xi9D/9IOmno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqLM5APk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqLM5APk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80ADD1F000E9;
	Mon, 15 Jun 2026 12:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781528320;
	bh=8lR/ezmey1Vj+wiH0lEfov/xGGidpFJa9T2B63E5xHE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=dqLM5APkTWkXETEWh5qs66ltoy10skp/3eIwTWShVJwXY/8Txy559XYvAmANhzQSl
	 4jf9xop6SWO/KuidmRuXwI3u5qcKePOsOOV5TCDOuPljal1o3nUCPqt9+oST8/Qqkf
	 VQzg5drzlod/pGxIOVBwWDhg78jSSf5t8KZZfFkVVryAX9JHitzAMtMO32y2JzY+KL
	 WTsWlE6hv+oZRF3k0NjQtXJPPU0tX6jw34CdikAVDrKXvRnJdvYY1c/Yp4RvF5XFAv
	 5yjTxmOrDn47jAtmzh4I15CWJHSaqD0+i+txzQFvgMVlhd1DsvrrpF0S7Dj9YTZPIE
	 aTvwIEnXAtwow==
Message-ID: <f731686b-4d22-4d22-b5b4-2409a165122b@kernel.org>
Date: Mon, 15 Jun 2026 21:58:28 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 1/9] slub_kunit: fall back to SW perf events
 when HW PMU is not available
From: Harry Yoo <harry@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>,
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
Content-Language: en-US
In-Reply-To: <20260615-kfree_rcu_nolock-v3-1-70a54f3775bb@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------CvbAk04er1zxFKbGiuTC0MZw"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------CvbAk04er1zxFKbGiuTC0MZw
Content-Type: multipart/mixed; boundary="------------NG9kPQSC4jZrLFe1DxL7i2Ih";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>,
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
Message-ID: <f731686b-4d22-4d22-b5b4-2409a165122b@kernel.org>
Subject: Re: [PATCH for-next v3 1/9] slub_kunit: fall back to SW perf events
 when HW PMU is not available
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-1-70a54f3775bb@kernel.org>
In-Reply-To: <20260615-kfree_rcu_nolock-v3-1-70a54f3775bb@kernel.org>

--------------NG9kPQSC4jZrLFe1DxL7i2Ih
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/15/26 8:05 PM, Harry Yoo (Oracle) wrote:
> slub_kunit uses hardware perf events to invoke _nolock() APIs from NMI
> context. However, creating a HW perf event fails when there is no
> hardware PMU, or when running in a virtualized environment without a
> virtual PMU configured.
>=20
> Since tests are often performed in virtualized environments, fall back
> to a SW perf event so that the test can still run, even if it cannot
> cover IRQ-disabled sections.
>=20
> For the sheaves path, IRQs are not disabled until the barn is accessed.=

> So some coverage is still expected.
>=20
> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
> ---
>  lib/tests/slub_kunit.c | 70 +++++++++++++++++++++++++++++++++++++++---=
--------
>  1 file changed, 55 insertions(+), 15 deletions(-)
>=20
> diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
> index fa6d31dbca16..11255fc8eb78 100644
> --- a/lib/tests/slub_kunit.c
> +++ b/lib/tests/slub_kunit.c
> @@ -303,6 +303,7 @@ struct test_nolock_context {
>  	int alloc_ok;
>  	int alloc_fail;
>  	struct perf_event *event;
> +	bool is_perf_type_hw;
>  };

nit: should have checked struct perf_event.type instead of introducing
a new field. Will fix.

--=20
Cheers,
Harry / Hyeonggon


--------------NG9kPQSC4jZrLFe1DxL7i2Ih--

--------------CvbAk04er1zxFKbGiuTC0MZw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCai/29AAKCRCGXBN6rc5S
1iiwAQCO/i4dUtvI7De9GTEkWrLWtNQjNkDEq/w/FjLTcTPUzgEA9cf42RSUBsjk
fmWcqz6vNOsWUTT4bQl5mQxgr4phsgM=
=XeJc
-----END PGP SIGNATURE-----

--------------CvbAk04er1zxFKbGiuTC0MZw--
