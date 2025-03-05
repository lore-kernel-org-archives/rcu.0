Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E94945C18;
	Wed,  5 Mar 2025 02:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143250; cv=none; b=cVONC7v0Hlai4bo6Ul3DCXEw5Ttdcuj+TkJ4va79Q3r3v9jW/sLZlSyb/p57Yxhyy0LJDagONJvmjQzJyyarB4VJslub7h6//HpODMXMbbDtcmo8e0PRWa0xMNz+5qegHX2DcBQlx6WuKbgA4Fy7VcbWSr5IWBkiipNSlPAtlBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143250; c=relaxed/simple;
	bh=EMuYMdqhBKQtfKn4RO+aq63aX39iNliJdyr2b5wjJMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=In9rRb1rUKWAc9GMGUXsrmhGjVALkUwa0eXoKtMdSFCbNjvFV5yv2+orSe/Rkraf251qt5lqQlPfoS/BzTbnx0IBNJBLu5OyamORfmJtzUfKbzl2Afn29ajO3wXIuiThO9g7fbBSPN05TKjcJscWCCFC6o3dUBSpQLkK+xS0/u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8dRx7vz; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8dRx7vz"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47210ab1283so93020001cf.1;
        Tue, 04 Mar 2025 18:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741143247; x=1741748047; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7IxSlL+2EA5j3XbfzMKhUhR9vhXqsS9YXraGxEpys8w=;
        b=G8dRx7vzrpABZzDRIQlitfCN6Kx+2NXA+sOSbrq8gvIpRoIdjdPUqp8Ham8+yfdwKK
         kI/0SWraWD4jMVHCzdyR4T0xJa2YCPj0TgwpgZprGZ9hTBhD/txQ7heey7aZ4KRbdIUh
         /0Hv5LneyogWyrY4GemS1ybWmKkqF+OQONP/9X/P0s+A9sbOEaGqKT4Gi/4fC+80av5w
         TeD58qUDDmuZGT+hU2jTYasdB9nwo8XcNUXiFVa+OQgjIAXNpfIkwANSVUWGn0WfTLOf
         z0HodakfeLDK8Ntb+38SPxKDqXjXD6jWaTDC1hM4EQ0YUirBH2iQ6VGKLRr12Z1on/yN
         dPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143247; x=1741748047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7IxSlL+2EA5j3XbfzMKhUhR9vhXqsS9YXraGxEpys8w=;
        b=g6Ci0VHF6gCarKBnGwf3vsou48ezoixq6ToW0UaXVw+mHukULPNE3PXpKmrF/hxfFf
         LRXH94pu2Oj4kWe+CRMlJT42cuOZaRAe/lniaLTsfrgugf3DCsnq8cbho6/OjOdWomTj
         KXDcSUqNmUeP5aXIDBE4pz5zUc+IedhcY8cQOR6CVcgq8sI33EYMIFjHbByIwP72PHye
         GKoqsVo6LRJ2idwzkfxZap3svA7OZkMTHQg/rQMJNerpntet/00Wy6nep7DdmWSzuDw9
         Py36ZzXRCOBwOYymnqcfTLhuqC13T9n648jGl6wcZiR0hwCtUY2d0WEDsYQQncZXbWlL
         /kBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWXet3Eoz4XBguJtAQAHJ9v8e0sRrOhH/OauCd7PFzq7u3veTchXYAc5Q4GffdqBvRZoOJ@vger.kernel.org, AJvYcCUYGdDy9O0XE+oNK4H9+H3j1ktjYQllUBdGNqTw48VOeae4slvfkqlBwYpJIrM9uNPEkSa4shzowV6KULU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOMO4qcFs6p8jPkUibZA1jdOHG7RK/2H54aJHvv8Wb/qtmQl2R
	123bRBPGwCtYVk9t4N/KKFunEN/09CZr0d/gxCds3BCKs9zK6Myc
X-Gm-Gg: ASbGncstOK+LVoQg4mspGA+6pfjmxpSCPxoKa3v2P8TV5XALjY843yJQLt12HgRQw5U
	Gh87921I9OT8+WZBPhcecnWQJ8+J6WBhjQADwuBx5LcKaEZUTW1ocOYDQ12/P7DMQOY+1u+wU2x
	Wsfm1q21UPyr6wwdkkAHoA+nIV22EA/RC8yJpSp0kXtHW9TlEH6445SKUkMXD4ghDI8d0kQvqJM
	Gcj/0QWFqK9ggtb57s1JSv+wdpgH3PnBx/kmYyeNdDcoYTGdW0Bcw0LeAio8mr0fyXCxuuNdjnQ
	Ss0KNrh80kfdyvoz2Tp1N2nB2omLTw2qUNPzIalXVi5PfpHQLBaLwr46Glck4O5BqpdHm7CuTpt
	497Tpq5d5M58Hbo41Bk8ozXmPLlQrgVcRHHg=
X-Google-Smtp-Source: AGHT+IFChScsO1pL9gVvgFXu/cdDXxG2PV+tQRp9rGpMRjXSE6qRwc9NpPsq0JZcpjvg9NGtyLu91A==
X-Received: by 2002:a05:622a:1888:b0:475:5bd:e9a7 with SMTP id d75a77b69052e-4750b4c95ddmr20045031cf.38.1741143247374;
        Tue, 04 Mar 2025 18:54:07 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4750a4cdc78sm6762071cf.15.2025.03.04.18.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:54:06 -0800 (PST)
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfauth.phl.internal (Postfix) with ESMTP id 51CCE1200068;
	Tue,  4 Mar 2025 21:54:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Tue, 04 Mar 2025 21:54:06 -0500
X-ME-Sender: <xms:zrzHZySvLhrU34s-wXLXDPxSg7qDi0w04WKzB5IPTVkOi58g4D5qJA>
    <xme:zrzHZ3wGYQwVYFBJ-qUOMOQyP658_7WilAUdbRnbbPQmZvU41XsD22vT3Gkpt__y8
    XKKRoTjekOxy-S_Dg>
X-ME-Received: <xmr:zrzHZ_2C0-oxxDtj-dNF0FubhM7Oac0QEzI9eB6PEXLj5mnFUvNITelBKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtqhfstddt
    tddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhephfeuhfelvedvieehvdetfeduveejteeu
    feefgeehhfeuieefgfdtfefhkeehgeelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhq
    uhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqud
    ejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgv
    rdhnrghmvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehurhgviihkihesghhmrghilhdrtghomhdprhgtphhtthhopehjohgvlhgrghhn
    vghlfhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepiiii
    qhhqtddutdefrdhhvgihsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvvghrrghjrd
    huphgrughhhigrhiesrghmugdrtghomhdprhgtphhtthhopehjohgvlhesjhhovghlfhgv
    rhhnrghnuggvshdrohhrgh
X-ME-Proxy: <xmx:zrzHZ-B_3W-TLRB2bATE3jbZ5A7vJXaA97HwY9LcoCtoF_RUO5txyg>
    <xmx:zrzHZ7h29gAw2BTi_a0kreyPzv0uo9wV5w_pCda0F5HJMeGuH1m7gQ>
    <xmx:zrzHZ6p4IFrsM4YqhIK6munuiZLPq62o3h5WOl2csG8Fb5DWr7BF9g>
    <xmx:zrzHZ-itkafyWz6KQLb1yPyrGwYu9SR5GpMpTDMX9sTFoowGnvPILw>
    <xmx:zrzHZ6RI1sWS7206kz-B3Smgy3zLUO8CX_dsACzSlPs5rZJNiBu42kYD>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 21:54:05 -0500 (EST)
Date: Tue, 4 Mar 2025 18:54:02 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Cheung Wall <zzqq0103.hey@gmail.com>, 
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <qlqvu355hs2vbj4tkfercqfpdynd7ezjg4uhg22hd6223yqh7w@4zp6haxokdpc>
References: <dd15fa79-70a5-4929-9339-51a47099c916@paulmck-laptop>
 <Z8H_aYBUHD2sS2Ir@pc636>
 <73724164-71f4-4671-b612-eb82a784da58@paulmck-laptop>
 <Z8IKs-I-YsOoS4uw@pc636>
 <cdab57a4-8d58-41d9-a9b5-71d425a7375e@paulmck-laptop>
 <f6803081-8243-4723-a3ba-00db351aafff@paulmck-laptop>
 <20250303001507.GA3994772@joelnvbox>
 <Z8ZyMaUhXMIxX7WE@tardis>
 <Z8bbary51FZ2TsUA@pc636>
 <Z8bcUsZ9IpRi1QoP@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Z8bcUsZ9IpRi1QoP@pc636>

On Tue, Mar 04, 2025 at 11:56:18AM +0100, Uladzislau Rezki wrote:
> On Tue, Mar 04, 2025 at 11:52:26AM +0100, Uladzislau Rezki wrote:
> > > > Did I get that right?
> > > >=20
> > >=20
> > > Other than I'm unable to follow what do you mean "WH has not been
> > > injected, so nothing to wait on", maybe because I am missing some
> > > terminology from you ;-) I think it's a good analysis, thank you!
> > >=20
> > > > I think this is a real bug AFAICS, hoping all the memory barriers a=
re in
> > > > place to make sure the code reordering also correctly orders the ac=
cesses.
> > > > I'll double check that.
> > > >=20
> > > > I also feel its 'theoretical', because as long as rcu_gp_init() and
> > > > rcu_gp_cleanup() are properly ordered WRT pre-existing readers, then
> > > > synchronize_rcu_normal() still waits for pre-existing readers even =
though its
> > > > a bit confused about the value of the cookies.
> > > >=20
> > > > For the fix,
> > > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > >=20
> > > > (If possible, include a Link: to my (this) post so that the sequenc=
e of
> > > > events is further clarified.)
> > > >=20
> > >=20
> > > Will add the tag (with the email you really want ;-)) and a link to t=
his
> > > email to the patch. Thanks!
> > >=20
> >=20
> > CPU_1:                                | CPU_2:
> >   # Increase a seq-number             |
> >   rcu_seq_start(&rcu_state.gp_seq);   |
> >                                       | add_client() {
> > 				      |   # Record a gp-sec state=20
> > 				      |   get_state_synchronize_rcu_full(&rs.oldstate);
> >                                       | }
> >                                       |
> >                                       | rcu_sr_normal_gp_init() {
> > 				      |   add a dummy-wait-head;
> > 				      | }
> >=20
> >=20
> > A client has been added with already updated gp-sec number, i.e.
> > "oldstate" would refer to this GP, not to previous. A poll_state_synchr=
onize_rcu_full()
> > will complain because this GP is not passed, it will on a next iteratio=
n.
> >=20
> > This is how i see this.
> >=20
> Updated the plain-text, removed tabs:
>=20
> CPU_1:                                 | CPU_2:
>    # Increase a seq-number             |
>    rcu_seq_start(&rcu_state.gp_seq);   |
>                                        | add_client() {
>                                        |   # Record a gp-sec state=20
>                                        |   get_state_synchronize_rcu_full=
(&rs.oldstate);
>                                        | }
>                                        |
>                                        | rcu_sr_normal_gp_init() {
>                                        |   add a dummy-wait-head;
>                                        | }
>=20

Thank you. I added links from you and Joel as the detailed explanation
to the commit log, and the comment I proposed[1].

[1]: https://lore.kernel.org/rcu/Z8SnhS_LnzN_wvxr@tardis/

Regards,
Boqun

> --
> Uladzislau Rezki
