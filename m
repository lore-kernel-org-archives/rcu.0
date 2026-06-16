Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1C533A70E
	for <rcu@vger.kernel.org>; Tue, 16 Jun 2026 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621488; cv=none; b=nkc65g0Y5PBL1f40nurAPyff7ag53B2R+2N9Po8F9Hz0QXpFJXG0Bp1OYJPOcMqjlp1GxCM2msPBW3zpGOQXG86N5YX//veuGd2Lli073ZDqiQ4XEO94VR/yZV9tQzsLlgWolfa6YnGgen9vXqjrZuhZNp5gidMc0p2aj1ogQ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621488; c=relaxed/simple;
	bh=8lg0lMM++bEYHjTp0b5ME3AVk0YuMGGw60/KhELAHHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOvH3o7LWOMa1TwPFjLKyHAPnPfkjjk9t7rP5ubxb0WejRDDSBZ3Dx/hkcqrSHGnR2Bt1BxRWpiyEijc9fWAQBlpl2sS09AnzlD7FGv4nfaqMI3Nx450wBgrQRJfnyX0xHpSVAiZ9gP2WVKKaRy206ZFBV06V/G7VbK+aYyKicY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=frlJVMVp; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="frlJVMVp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1781621480; x=1781880680;
	bh=8lg0lMM++bEYHjTp0b5ME3AVk0YuMGGw60/KhELAHHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=frlJVMVpec64vFDqx5fdB8XDPtgKB/tWL7HRxgIspC73pZxexP3/M6050v9LV+EBR
	 5eU27vNdh69Jajt1fmYlyjG84fyrFsk0Gm7ZwrahvHwnuv1CtNkWd3EzOw9EECf/oV
	 1f1LdftmcQxuBLZlGi+kMPfJ6hW1CkEF6lvNjKF5ivzHfukwBIB1QPns1GmJAMatjz
	 hbXFPCA/0Nh1XVHUTEiCGmPJE0blabPn7rWYC4yPekp4CtWK6UNrC4IGvPWhphzQVV
	 P68Zg0VJ9i0SkCm1ec/2B89kk1K9RwlSGc2ENeJz30CxDj2cr15Qnc5MBtyp6+racn
	 TFN9SXPp7E7BQ==
X-Pm-Submission-Id: 4gfqgP6Gpyz1DFGT
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Philipp Stanner <phasta@mailbox.org>
Cc: Philipp Stanner <phasta@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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
	Daniel Almeida <daniel.almeida@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Igor Korotin <igor.korotin@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Krishna Ketan Rai <prafulrai522@gmail.com>,
	Shankari Anand <shankari.ak0208@gmail.com>,
	manos@pitsidianak.is,
	Boris Brezillon <boris.brezillon@collabora.com>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH v2 5/6] rust: Add dma_fence abstractions
Date: Tue, 16 Jun 2026 17:51:11 +0300
Message-ID: <20260616145112.14201-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <d074d3105a2c1d4f594bc6d7b0b09e62757790d5.camel@mailbox.org>
References: <20260616082819.2943886-2-phasta@kernel.org> <20260616082819.2943886-7-phasta@kernel.org> <20260616124755.460550-1-work@onurozkan.dev> <d074d3105a2c1d4f594bc6d7b0b09e62757790d5.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jun 2026 16:38:51 +0200=0D
Philipp Stanner <phasta@mailbox.org> wrote:=0D
=0D
> On Tue, 2026-06-16 at 15:47 +0300, Onur =C3=96zkan wrote:=0D
> > On Tue, 16 Jun 2026 10:28:17 +0200=0D
> > > +=0D
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // DriverFenceData is rep=
r(C) and a Fence is its first member.=0D
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let fence_data_ptr =3D fe=
nce_ptr as *mut DriverFenceData<T>;=0D
> > =0D
> > Either the field ordering on the type or this code is wrong because the=
 first=0D
> > member of DriverFenceData is `rcu_head`.=0D
> =0D
> Yeah, that's a bug introduced in this revision. Thx for pointing it=0D
> out. Already fixed it downstream.=0D
> =0D
> I'm just wondering why my test did not blow up.=0D
> =0D
> > > =0D
> > > +}=0D
> > =0D
> > I am unsure whether it is safe to cast the pointer in Fence::from_raw w=
ithout=0D
> > Fence being #[repr(transparent)] as the layout compatibility is not gua=
ranteed=0D
> > explicitly.=0D
> =0D
> Shouldn't #[repr(C)] do that trick, too? Do you need both?=0D
> =0D
> Who can answer that?=0D
> =0D
> =0D
> P.=0D
=0D
You shouldn't use both and I think it wouldn't compile anyway. repr(C) only=
=0D
makes sense when the type have multiple fields.=0D
=0D
Thanks,=0D
Onur=0D
