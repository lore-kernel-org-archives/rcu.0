Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD796FC0A;
	Wed,  5 Mar 2025 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192852; cv=none; b=QV30j03+3sq7o+nJ7aFreQaUdNMLzw6JqAFJ8cRTnxyJMWxwNvO6T8x2pXs/pHMYnasmMdXqlI69A7WhfhH3h2wMpjesB1PdjkIiN1OhxAKgiXrjL9jOEAoL4qcT+5Gjn23a0lzLOlvwebI0pit8EaPxI5TE4IyuoVuFFlKEv0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192852; c=relaxed/simple;
	bh=nz9idnKwRN7ELYDezSGAy0VDIQCJ0u8rHHSN4twt/D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQUuCnVPEmlo8ZZO6XTr4ata1cZMPhG0pbh0u85lv6/Iu7zt1mNUFaevDmqozZH9oWOK9BT3vayROlrHzO3TC2kvmwLfnVJWOJcELsVJFfWFKG6pipFp4xYHoEtMEfr+gadxGy4oBoSAwz0EDHvoVotVPaengk8Dn+eQL5SAqgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdAvZpS4; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdAvZpS4"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c3ca86e8c3so180806485a.1;
        Wed, 05 Mar 2025 08:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741192850; x=1741797650; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1tFyA/a+p+oRSXMY15FOUN9WaZSHGQMbaRR9qknORC0=;
        b=NdAvZpS4/PokpdRujCp1YFZVZImfOfiRbdsqAt4Rky6WR/PY/FK16jhhfue1RFcE6p
         P7DnHgkK+DHPXpEueNP3spywpvSf+QqByLYFt5Zj8HXkQwA8JTNijC+POUptLSyeERZp
         nM7GMg5+LSbb9vwBop3KMoEYxJJmlLNK5Y/yVoK0Uld/pg/l5WXT5bbADLMvDs1tmVcj
         aOlYBoa9GCcX6M39XIy0inoFCEyLXfWGWAzgLSkudG8ldhA5+ZtFz9rLehvl0KSE0iFj
         FxryLjtReDLW7WuFxw/gtApSeZWpg0Yu1E5jLwpgL60fGS6BJrUDMJ5cZeIx+kO2w9Pp
         qc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741192850; x=1741797650;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tFyA/a+p+oRSXMY15FOUN9WaZSHGQMbaRR9qknORC0=;
        b=trw0wp+wCstSpW3Y+ldmwcaqqUcw4Shpxwd8fBwMzAC0J3ddMVqyC3dPq48gi+8IFI
         ZU7oBWyy4Kkf+MPcliA9FEB/8wcPE2nhcYZwAYoF5yOfTrUdioRdXjdtLRiQNCHb5npl
         ByU7KyB3gxequjre0YzXXfFWxQkNt1j/D4DnNauc1fl021kKiyWYASOcDfC5Ou+Tdcn3
         WoqHN4dym58Pw4N4npY7E4fuHuHP1Srg0cLONdHo+GrRr1aNU0Punv20S8ryk08LHoJr
         9l3UlKpgqIpJp3Hjq477JizrKiTAVUDK90yVxjdCYNVyoaCrWh0lGBYRdVTPfriTTzn/
         +Ocw==
X-Forwarded-Encrypted: i=1; AJvYcCU3YR7aNMvnx1d99CjjG1Fbzku7oUVJ7TgJms5x17iAA2wruk16+aVS3NS7vMWk73ugxpV+Cy2xrds=@vger.kernel.org, AJvYcCVOD3JqB+R4El9GwGpt58zlf/0ptj1c1pZJ0i0KMFAYf5mQWOzKDH93Z6vLvLzekARbpHhH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2iiRnos95OK3F/bLFruiBrE5b7W4GXDfSXFXahEQth8PWFrk8
	d9BpNjYej66ZvXiDqlDIf4Nl/UBncGtuHUqMsm52mxgx8bh72nON5ASvdw==
X-Gm-Gg: ASbGnctxr7zJV02UVF95fdLyR6JOOaP2ZQDYEAZig2xlIyXVyq0P0mEbyGg39695R7y
	KB984YfxJX29sGmw+8IrqulYGOl4dlfy+0m9KUwV2qwUBcMsb4/VfMP3cReZcJ2tFabluzcTWFp
	T5uv5dQpwRXGLrpzNk/UisZBiMFVa7Rjx9L/K3bst2IiBnu9IxwqgplGU5F12DEN8Jko4u7bioP
	MaOfAjRT11oUUQG8vE3Hz4KIf1RwhTFIxUOlbNytWFRxB2xYzLBgyvccUkc9TpO2IXSzhB6q7Oa
	uKHBrvoYCfUm5yjgbMxX/91nN2C2WcjHvGA55muUyWFFoj2mHcIk+amv2ujM2aMA4T6n6mmIwhQ
	ar7MKJyJYy5epsO42fjbUIyw7I+q5hLZXl5Q=
X-Google-Smtp-Source: AGHT+IGqOaDBCwoZkYhh0Q34X9QFE22KoSf5uvk36qPKiwxTAIpX9rfxcQcq2W7lSCjHwHtMfKs7kA==
X-Received: by 2002:a05:620a:4693:b0:7c3:d91c:8d06 with SMTP id af79cd13be357-7c3d91c8d47mr522950785a.0.1741192849774;
        Wed, 05 Mar 2025 08:40:49 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3b53ce7a6sm477016985a.31.2025.03.05.08.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:40:49 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id D8EE21200066;
	Wed,  5 Mar 2025 11:40:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 05 Mar 2025 11:40:48 -0500
X-ME-Sender: <xms:kH7IZ4PW6aaxwdmgNcYeLiYGAHvfsRb_4YnNauiHhPOlr9l4BgRFQQ>
    <xme:kH7IZ-8jBMuvv8ac4WHQIGlQkhFwo0n-lAfsiRBLKNGsm4HmVprATMEeKKZ_0Wt8b
    LBkBlHPb0-Enx5C7Q>
X-ME-Received: <xmr:kH7IZ_RewIL4kue_ZQR_s8aXUJKQbC-rFGGoG2brgWMNG-N5m6ceBvxNwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddt
    tdejnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepfedtvdfgudfftdfffeejvdegtddvvdfh
    kedugfegkeeftdffledtueetgfevkeetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhq
    uhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqud
    ejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgv
    rdhnrghmvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhhmphhgohhurhhiuggvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhitghh
    rghrugdrfigvihihrghnghesghhmrghilhdrtghomhdprhgtphhtthhopehprghulhhmtg
    hksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrughhhigrhieskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epsghoqhhunhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:kH7IZwsSC-dIn-b_mQRL8eIqiJDxPi1SGIFL3jAwoyZJjSs6bM1Qog>
    <xmx:kH7IZwdVVLo0j-9y5Hu8O9bGh6gwgodS46rIgPLxrEBaGSeK308KIw>
    <xmx:kH7IZ00apw9dS5W1NbNM5wn6cNBWulwP52AaZFpdSxOM7fn-dqwtwg>
    <xmx:kH7IZ0_yYEPXz_fk96m_AN_DldwGUKSQkhOo5ytCFOHr-6BPZUuT7Q>
    <xmx:kH7IZ3_yfrUfFXlN3cokF2N_SGZVUlIj7MwWSlw8RKzvWtBeg35qvx0w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 11:40:48 -0500 (EST)
Date: Wed, 5 Mar 2025 08:40:41 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alan Huang <mmpgouride@gmail.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, paulmck@kernel.org,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	rcu@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [Patch v2] doc/RCU/listRCU: refine example code for eliminating
 stale data
Message-ID: <Z8h-icfF3Eu8mceb@tardis>
References: <20250218005047.27258-1-richard.weiyang@gmail.com>
 <AB18BC5D-AD55-46DF-939C-44DFA845D168@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <AB18BC5D-AD55-46DF-939C-44DFA845D168@gmail.com>

On Thu, Feb 20, 2025 at 12:40:20AM +0800, Alan Huang wrote:
> On Feb 18, 2025, at 08:50, Wei Yang <richard.weiyang@gmail.com> wrote:
> >=20
> > This patch adjust the example code with following two purpose:
> >=20
> >  * reduce the confusion on not releasing e->lock
> >  * emphasize e is valid and not stale with e->lock held
> >=20
> > Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> > CC: Boqun Feng <boqun.feng@gmail.com>
> > CC: Alan Huang <mmpgouride@gmail.com>
> >=20
> > ---
> > v2:
> >  * add the missing parameter *key
> >  * make function return struct audit_entry
> > ---
> > Documentation/RCU/listRCU.rst | 10 ++++++----
> > 1 file changed, 6 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.=
rst
> > index ed5c9d8c9afe..d8bb98623c12 100644
> > --- a/Documentation/RCU/listRCU.rst
> > +++ b/Documentation/RCU/listRCU.rst
> > @@ -334,7 +334,7 @@ If the system-call audit module were to ever need t=
o reject stale data, one way
> > to accomplish this would be to add a ``deleted`` flag and a ``lock`` sp=
inlock to the
> > ``audit_entry`` structure, and modify audit_filter_task() as follows::
> >=20
> > - static enum audit_state audit_filter_task(struct task_struct *tsk)
> > + static struct audit_entry *audit_filter_task(struct task_struct *tsk,=
 char **key)
> > {
> > struct audit_entry *e;
> > enum audit_state   state;
> > @@ -346,16 +346,18 @@ to accomplish this would be to add a ``deleted`` =
flag and a ``lock`` spinlock to
> > if (e->deleted) {
> > spin_unlock(&e->lock);
> > rcu_read_unlock();
> > - return AUDIT_BUILD_CONTEXT;
> > + return NULL;
> > }
> > rcu_read_unlock();
> > if (state =3D=3D AUDIT_STATE_RECORD)
> > *key =3D kstrdup(e->rule.filterkey, GFP_ATOMIC);
> > - return state;
> > + /* As long as e->lock is held, e is valid and
> > + * its value is not stale */
> > + return e;
> > }
> > }
> > rcu_read_unlock();
> > - return AUDIT_BUILD_CONTEXT;
> > + return NULL;
> > }
> >=20
> > The ``audit_del_rule()`` function would need to set the ``deleted`` fla=
g under the
> > --=20
> > 2.34.1
> >=20
>=20
> I think it=E2=80=99s good enough to illustrate the intention here:
>=20
> Reviewed-by: Alan Huang <mmpgouride@gmail.com>
>=20

Queued for further tests and reviews, thanks you both!

> Boqun, there is an unreviewed doc patch[1] that fixes the section
>=20
>  =E2=80=9CUsing RCU hlist_nulls to protect list and objects=E2=80=9D
>=20
> [1] https://lore.kernel.org/rcu/20240326124431.77430-1-mmpgouride@gmail.c=
om/
>=20
> : )
>=20

Will take a look later.

Regards,
Boqun

>=20
>=20
>=20
