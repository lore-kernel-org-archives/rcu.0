Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ACA470436;
	Wed,  5 Aug 2026 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785944234; cv=pass; b=EJbDtrkkwkBORa6WdVD3DYRTjs9bs8DhHJzwIkYtz1ySeIjVfSvmO49h04LS8KYu1rWux4tiOn/XXehTaE2kKw4qStdhkLWLwXbyNTUUeK/I+h0Chs9mseliNE9spbZe/aDOAyIaL6kaFIKBR0IJSHCWCGOnwc2eUm2OJoZj7ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785944234; c=relaxed/simple;
	bh=kE7DK9uZyfkGsQKAsQEe7Ws0XS/oIzL28ZzMERbIBrA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ifW3Y7UtRqVGX8N1A1DHGX05okT70/dwje/AeFwSt1U0UPWIYhZ7CbE7a7QQy+ke7vCRhVQllVhYxwahdxKLzYTz4OLNAe8PJblTza5RE9OoVJoBA5feWqvyClQhR+JTTEJakFoOLCrFuos0AG+eWZlWy/MIEqnkbiDiSTtV/g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=H8fEDiQ2; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="H8fEDiQ2"
ARC-Seal: i=1; a=rsa-sha256; t=1785944179; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=B9NH8tzwGNXvVBin7CP/ryrYN/Nzf4YWB1eQLfcmvR78ykfbvCVCsbyXTl4vQLdRv9Z6DIqQLU1StApVn/q1d1jzv62GlRviM/+H8dl4yiskP712XNtFVae7wnGKIHf1Mu98kTMMxcYBrlDniqv+7j2rAcLFbhSsMhafqXc63iY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785944179; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eZ8yoGo952efns/OBm5iCX+Q1HBcqsTJ1juv/oJ+doc=; 
	b=NQfB0LZQ6S7Y5T7XcslYroMwDtkLTHfBsqcVTOYaFO8exvYuw6dI34qp4jCC1tAguAQUTdqs8GW7bJcfh/+gMJEZIr0kFTVS6qeUFJtz2LkVNIHOjwaAZTIn6RFTjaIZ2/fTfv69FPDKrae+VbZsrBvMIMH13U+aZ6IN2LDM7eM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785944179;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
	bh=eZ8yoGo952efns/OBm5iCX+Q1HBcqsTJ1juv/oJ+doc=;
	b=H8fEDiQ2taUmnCpqfECXXNNC8QPx70VxDDG3gmJIss9JCsaukridaFIrfYoxu9H9
	DsbmnjJlKy4I0uyABZe/acOUra03AWhqFdVoEfwbrrFA+4cwsQ+iB0YaqJPF7lBIepr
	tCfCabq9PvVdiyjYIpCcJmtzGdyQLNc3myvI8ON4=
Received: by mx.zohomail.com with SMTPS id 1785944177660785.6057907562056;
	Wed, 5 Aug 2026 08:36:17 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v9 4/5] rust: Add dma_fence abstractions
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260805145949.938505-6-phasta@kernel.org>
Date: Wed, 5 Aug 2026 12:35:51 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Lyude Paul <lyude@redhat.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Josh Triplett <josh@joshtriplett.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Asahi Lina <lina+kernel@asahilina.net>,
 Burak Emir <bqe@google.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Eliot Courtney <ecourtney@nvidia.com>,
 Mirko Adzic <adzicmirko97@gmail.com>,
 Timur Tabi <ttabi@nvidia.com>,
 Daniel del Castillo <delcastillodelarosadaniel@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org,
 rcu@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <777CE025-C1AA-4C3F-9B56-CD157C8523E7@collabora.com>
References: <20260805145949.938505-2-phasta@kernel.org>
 <20260805145949.938505-6-phasta@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 5 Aug 2026, at 11:59, Philipp Stanner <phasta@kernel.org> wrote:
>=20
> C's dma_fence's are synchronisation primitives that will be needed by =
all
> Rust GPU drivers.
>=20
> The dma_fence framework sets a number of rules, notably:
>  - fences must only be signaled once
>  - all fences must be signaled at some point
>  - fence error codes must only be set before signaling
>  - every pointer to a fence must be backed by a reference
>=20
> All those rules are being addressed by these abstractions.
>=20
> To cleanly decouple fence issuers and consumers, two types are =
provided:
>  - DriverFence: the only fence type that can be signaled and that
>    carries driver-specific data.
>  - Fence: the fence type to be shared with other drivers and / or
>    userspace. The only type callbacks can be registered on.
>    Cannot be signaled.
>=20
> Hereby, a Fence lives in the same chunk of memory as a DriverFence. =
Both
> share the refcount of the underlying C dma_fence. Since this
> implementation does not provide a custom =
dma_fence_backend_ops.release()
> function, the memory is freed by the dma_fence backend once the =
refcount
> drops to 0.
>=20
> To create a DriverFence, the user must first allocate a
> DriverFenceAllocation, so that the creation of the DriverFence later =
on
> can always succeed. Otherwise, deadlocks could occur if fences need to
> be created in a GPU job submission path.
>=20
> Synchronization is ensured by the dma_fence backend.
>=20
> All DriverFence's created through this abstraction must be signaled by
> the creator with an error code. In case a DriverFence drops without
> being signaled beforehand, it is signaled with -ECANCELLED as its
> error and a warning is printed. This allows the Rust abstraction to =
very
> cleanly decouple fence issuer and consumer by relying on the =
decoupling
> mechanisms in the C backend, which ensures through RCU and the
> 'signaled' fence-flag that dma_fence_backend_ops functions cannot
> access the potentially unloaded driver code anymore.
>=20
> Signalling fences on drop thus grants many advantages. Not signaling
> fences on drop would risk deadlock and does not grant real advantages:
> By definition only the drivers can ensure that a fence always =
represents
> the hardware's state correctly.
>=20
> This implementation models a DmaFenceContext object on which fences =
are
> to be created, thereby ensuring correct sequence numbering according =
to
> the timeline.
>=20
> dma_fence supports a variety of callbacks. The mandatory callbacks
> (get_timeline_name() and get_driver_name()) are implemented in this
> patch. For convenience, they store those name parameters in the fence
> context, saving the driver from implementing these two callbacks.
>=20
> Support for other callbacks (like for hardware signaling) is prepared
> for through the fact that both DriverFence and Fence live in the same
> allocation, allowing for usage of container_of from the callback to
> access the driver-specific data.
>=20
> It is expected that other callbacks, added in the future, also mostly
> operate on the generic data in the FenceContext. To make this safe, =
the
> implementation ensures through a lifetime that a DriverFence cannot
> outlive its FenceContext.
>=20
> Synchronization for dma_fence_ops callbacks is ensured by only running =
the
> Rust deconstructor delayed with call_rcu(), which prevents UAF-bugs
> should a DriverFence drop while a Fence callback is currently =
operating
> on the associated driver data. Since they can also operate on the
> FenceContext's data, its drop implementation also performs the =
necessary
> delay with rcu_barrier().
>=20
> An additional issue discovered during the review process of this code =
is
> that there is (currently) no mechanism in Rust to prevent someone from
> circumventing the DriverFence's FenceContext-reference's lifetime by
> "forgetting" the fence, e.g. with core::mem::forget(). This would =
enable
> UAF bugs on the FenceContext. Throw a panic if this happens and =
document
> a path towards a more robust solution.
>=20
> Add abstractions for dma_fence in Rust.
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
>=20

Owing to the ongoing discussion in v8, I still think we could propose =
some
refinements in the future, like most source code out there :) But =
overall this
is a solid base to build upon and it doesn=E2=80=99t make sense to delay =
seeking
the =E2=80=9Cperfect=E2=80=9D solution, if such a thing even exists..


Thanks for your hard work here!


Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

