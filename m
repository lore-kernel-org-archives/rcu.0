Return-Path: <SRS0=nRMg=BI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A413DC433E0
	for <rcu@archiver.kernel.org>; Wed, 29 Jul 2020 01:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D1852076E
	for <rcu@archiver.kernel.org>; Wed, 29 Jul 2020 01:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIV4BAKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgG2B2e (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Jul 2020 21:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgG2B2d (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 28 Jul 2020 21:28:33 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C871C061794;
        Tue, 28 Jul 2020 18:28:33 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g26so20795655qka.3;
        Tue, 28 Jul 2020 18:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s7bJx0rYl1a+M+oQEsz/37KXGNMFb9aDvZSo9YODdFo=;
        b=pIV4BAKfxK9lNlh1T61AATC/xbzXROl5gQXyaXxFTPiWtw81dMcIdNYiHOP6FjCBYu
         tIc8Xf+SxEGso+TEDomlrteqf3UaRNEt53nMXuQutVDynQRrwjAKTCs7xOPH53HVhsOv
         scxyCnL1kl4VLnW+F47P5kG1FM5j+tfB/KNbqLNln/XLSWzlheGRiefFBQo2AFQeaOLM
         jIB/dfWwfiXBh8cN4LcY1nEb8XtpI5XlmluzRbWIHxsXHcML2U79kJW/Fq7+sk6GfQKj
         clCmXc24LZA4DO4mv+0I01d/RbfiReqmSVuGhXZB7prWrKqB4N2gYcx1unTa42VqCCVm
         1w1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s7bJx0rYl1a+M+oQEsz/37KXGNMFb9aDvZSo9YODdFo=;
        b=mdUZage+W9zewFT2Pufrh2OpyyIMsEEl7OtQJnCWfpdE3R13RwhlPMCYZFtiMyB++P
         bLGgWHt0SyE7IDSEZ0+hwoNKDDlr/Q3wfJOm+GUe17Kyx+ujOi834yZipreGIENTKFK9
         BHjorJw4eoLeJvbeNzKCyOo5n9IAp02f+qs/LE6GrkbESutYuAm5v3nvZdutmki9Hk6g
         ZQwTg8rUFz3F3vjDYsB5FvX9HPslNW/xqFZSAitNr89Ywjt1awDOXaetkGym7O60tIvf
         kENGn8WFKPQZ9S9/WIMYY8fYfJjVaqQPQ/TXNvAjVQzXY2w4pvfO37SIJ0c8tDZedQd6
         CwfA==
X-Gm-Message-State: AOAM531FKkb5dnYkfnDnVltxXm+lD7R3R0VQoicDeXRnji+Ps7ioaeLM
        KXpzVgfSl5C6gReB2Nu0Mo8=
X-Google-Smtp-Source: ABdhPJy4/nLwI+NNNVuHjOzuzf7YCMYX/4IZgBTBoxyZF2Ftum0RLQS5ZPYPUKC7TjU0/Fz+MbwBPQ==
X-Received: by 2002:a37:ad0d:: with SMTP id f13mr2464463qkm.274.1595986112626;
        Tue, 28 Jul 2020 18:28:32 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id w11sm514142qtc.58.2020.07.28.18.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2020 18:28:31 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id A69FF27C0054;
        Tue, 28 Jul 2020 21:28:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 28 Jul 2020 21:28:30 -0400
X-ME-Sender: <xms:vdAgX9-1J1suZGytstJHtbNtMtAz-3-OcWRV2oyNix8vpJPTwH253w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrieefgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehfedujeeuffejleektdegleellefgfffhhfdvhedtkeevheejiedvjeeguddu
    geenucfkphepuddtuddrkeeirdegjedrkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:vdAgXxvm2NAraJmxzHqdAQHtkirHTMjI74EpbnM4tHccsajzz8STQg>
    <xmx:vdAgX7CTWk0NYRu9AwKdQxUvP7BCnN6-U-Raq4UCQLhEK6g-gPh22g>
    <xmx:vdAgXxduZFs4TuSgSOzqA9o2lK5bTN3cxf0CFFX5W3Bsa4Wpmm05IA>
    <xmx:vtAgX-BQ-iiDAC-s1z2puRVu8FZM2ZFfbCKPz3LoxOdUAZZYw1D0qg>
Received: from localhost (unknown [101.86.47.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7FF243280063;
        Tue, 28 Jul 2020 21:28:28 -0400 (EDT)
Date:   Wed, 29 Jul 2020 09:28:21 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC v2] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20200729012821.GA136701@tardis>
References: <20200719035518.2386828-1-joel@joelfernandes.org>
 <CAEXW_YQhYiYQZOJ95dqBcu_fAZ_6k7HGbrw53eTgPrgXU+5few@mail.gmail.com>
 <20200719041841.GA2398236@google.com>
 <20200720082211.GA35358@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <CAEXW_YR4dxuPV+Yu9HcYCSAdiV1H=9Rk9HJgCST-YMMc7J2Mgg@mail.gmail.com>
 <20200727134925.GB79404@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200727230323.GA3390623@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20200727230323.GA3390623@google.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2020 at 07:03:23PM -0400, Joel Fernandes wrote:
> On Mon, Jul 27, 2020 at 09:49:25PM +0800, Boqun Feng wrote:
> [...]=20
> > So C11 features are available to gnu89 as extensions, also I tried to
> > compile the following code with -std=3Dgnu89:
> >=20
> > 	#include <stdio.h>
> >=20
> > 	typedef struct {
> > 		int a;
> > 	} atomic_t;
> >=20
> > 	void g(void) {
> > 		printf("this is g\n");
> > 	}
> >=20
> > 	void h(void) {
> > 		printf("this is f\n");
> > 	}
> >=20
> > 	#define gen(x) _Generic((x), atomic_t : h(), int : g())
> >=20
> > 	int main(void) {
> > 		int a;
> > 		atomic_t b;
> > 		gen(a);
> > 		gen(b);
> > 		gen(b);
> > 	}
> >=20
> > , and it worked.
> >=20
> > Besides, please note that in include/linux/compiler_types.h, _Generic is
> > already used.
>=20
> > > > With these primitives introduced, you can avoid () to add those
> > > > rcu_segcblist_*_seglen() which have #ifdefs in them. Of course, an
> > > > alternative would be that we implement rcu_segcblist_*_seglen() usi=
ng
> > > > _Generic, but I think someone else may have the similar problems or
> > > > requirement (already or in the future), so it might be worthwhile to
> > > > introduce the gen_ primitives for broader usage.
> > >=20
> > > One issue is code using memory barriers around the operation, such as
> > > in rcu_segcblist_add_len() where you use smp_mb__before_atomic() for
> > > the atomic version, and regular smp_mb() for the non-atomic version.
> > > So ifdef will still exist to some degree.
> > >=20
> >=20
> > Right, I think we can have two functions: long_add_mb() and
> > atomic_long_add_mb(), this part is similar to ifdef approach, but we can
> > make a gen_long_add_mb() based on these two functions, and
> > gen_long_add_mb() simply switches between those functions according to
> > the actual type of the field, which I think is better than ifdef
> > approach at readability and maintenance.
>=20
> Thanks for clarification. I agree with your idea, would you be able to wr=
ite
> a patch to add the helpers my patch can use?
>=20

Sure, I will send a prototype to see others' feelings about this, will
try to get that done by a day or two, so hopefully it won't block your
work ;-)

Regards,
Boqun

> If others are Ok with your idea, I can go ahead and use your helpers.
>=20
> (I could write the helpers myself as well, next time I send the patch).
>=20
> thanks,
>=20
>  - Joel
>=20

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl8g0K8ACgkQSXnow7UH
+rg2mAgArvrSA66zszPpnXs/12qdRJQHheaRydnJj6wGjkfE8IfgERXE45Qdlu1W
aeZ2KcjEv8LZHEdK6TU8MgFvEC5TDiUi4mc6YYRBNCN9A4ebDP1QWIjLW5K4RUAy
5ET4TIowJX7uJ61uCidcjTxqnrFB11Ro5laETYffavcEkMkCjUkz06GcR2SYB6dn
9CgSz68RllKVDmu9UI0Gn/z3Q8UBErFLg1e92jHLviYUM2o2IqDHo7TRVhnFKXPC
QAawhkfayzY4Qvhg0vsQ4hyP76uyVHBQSnJKs/3jWJBJWrYAajYWgat8TW5HvjOp
PTKzFNV5kdmUxgea5FP+kZLMAgHK6g==
=ZCh6
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
