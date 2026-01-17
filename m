Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F79514A4F9
	for <rcu@vger.kernel.org>; Sat, 17 Jan 2026 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768658724; cv=none; b=ay+JgjFBiVQ4HYU73dLjhNMQ8qSHeHhiIiY0xBODFjJIdqevoyiFsCo1hOz2CCOgUokpYJDgJhWIbLxqUDbXEllWjFmZE/0hdTGpl0+IkGvO2oHflL9x5VfbOwPEADWsYrxtb8lGl9f5XHxbL1ZoY6W/1uzS0pvGXhI9o7tDmxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768658724; c=relaxed/simple;
	bh=7MdMVUO0EO6V79fSSuCpKyithykK+f/vpPoOhgXQ58A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzmLB32ilG17FO/dsk9NsMsFGdUH0MjQnw4IcIaG4u4YfYdyElGbuMxHL5J3e9z+DKyCc0EXp8xaqewdXhBSjaqufpqR+2R6bx/khl9LI0nUaAFxOBdIy58Rm1aUFGmEWs0Y6mZdsJoxipOzxHQuSWnc9vOIW5nw7Cs4WRUF1Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaylbKrY; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaylbKrY"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5014d4ddb54so32224181cf.1
        for <rcu@vger.kernel.org>; Sat, 17 Jan 2026 06:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768658723; x=1769263523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVIBuJm40ZFRv182tq23WWphNrxzPrOdcziw4l4EFIg=;
        b=LaylbKrYmh6XPrIZ2cnsVucP2kHgYJ42OZa4i34HjZHl74VE7+UtbtraEHmSJ6RYbt
         tcaeZs3HLx9YPfC+skgy3tR4tHc+gqW4HNFqvt04L5WSljZQdItE0VEDsafFb1VVeFbb
         MYIKwNcVWcue/0VNqh0cFcOlyqv4nim779DTse9EBu0+Ft5w37X6E+9iDtFjaHYuScSF
         K+filhb/psFn/cfdBVBmqrTR1i756zFcGYWlzGM+q5PEnBtMbqIKfvBGfhdlYaEBVofM
         baQoExz5OTsU5AdYwrw1hsaEkC4x3h8BPYD1qsIUUuQwz/s3iPvcqTGu6EbUqBmuCVQp
         K4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768658723; x=1769263523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tVIBuJm40ZFRv182tq23WWphNrxzPrOdcziw4l4EFIg=;
        b=bPRAsnfhUrkEqYqmTGsIf/69jVnA97gCN8b2DHIfGFdmhB1Ua0bUTpUtQRG1K3fbRL
         R7UTEAAViiDStLkMJjyPt7mAnTNVbGP2xIiROhyxDEyMb6P2B7srIsAVhs2fReuS96tA
         Y5wha9yCjJA6K4k+SaykcCt/6wi7ZJepQvFxeCc9QKFVRbDodVNg9tA9OLfrzXzDba9m
         UMtzIX8P8aewJ/7PHiMPgN2j1TLxccRgp+CiCc0uvypSjA8R9qsZ4oPP0tLMJTbAU9ck
         l6fXGSHzQOc/jIvCmteJUn6lyzg7UBZvN83P2I9iiwEdvQtEFAPGEeWSV5l7UzuOeW/2
         iwXA==
X-Forwarded-Encrypted: i=1; AJvYcCUI7dgxAi3cebqmwk1ibRMTLaNV/z/WFaEPEyS4DllXrqbbsjfdOtwNvZDZVEZEF6MmZB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1UwM+XIhhGi3plv11gYuPKCuX/4r5lDno1URIeqLE/XVjFLPv
	2TW3gUzCRJ/xbsS7g+EHvngHnVk17i9cY+3rPwQtOVmSwggstCh3QZB/
X-Gm-Gg: AY/fxX58kn13VdxPj+JTVwsrVuGCYBg1/RKurx37xJk5W7GxaMrXQkrkJQ05lk81WAX
	y8Tuv8tivlk6CrnPD9GC2BD4KOBg9xA1IleiQKPjREo2sW9bYyCc5OJUw6pKHhWMS1OAAwLHYqS
	JPdslxRA1/KeefQfrsQN1QzjeYeMFJ671AgKfrWQ1pawxBloWIKYKlU3Cyf+DBWd47Qe2drGxcW
	aLlMeOWeiP2OilhVNIiIdBnoSfM7bOhPlf2ppH4kt5T1qBHQhvi9f/rWYAuDNXlZEDa8BOfWFvI
	zNWZltSk+Zpb8/nkS2PBtKVHTptvywet2mWBwGPhWzUqY+cbLVRjJf1eWhm9nHDqedg4H0pheWQ
	xNc/T6oIUto+z1nvIQRDzPvunNjb+8oQKwp4ZnY7ubP0NEIP1ou6VQb16FdZLeCfMqoOj+pbbn3
	de1SNqMZB1XiJG/OdMCpdd4J/pEkFEw83eUcU22cAWMojxAlz/Au1czSt8w7nLKAh70VPHlMWCB
	X+ClIt1cE2rv3loHHcqyiCObQ==
X-Received: by 2002:a05:622a:11ce:b0:501:4419:8abe with SMTP id d75a77b69052e-502a179c6f7mr98087771cf.64.1768658722461;
        Sat, 17 Jan 2026 06:05:22 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e5e535dsm47367086d6.4.2026.01.17.06.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 06:05:22 -0800 (PST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4C7BEF4006E;
	Sat, 17 Jan 2026 09:05:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sat, 17 Jan 2026 09:05:21 -0500
X-ME-Sender: <xms:IZdrafiAFgNQQd9pfYdiNAn_YIRfMuyFBrjGkPup0owLwDDTlulhng>
    <xme:IZdrab449p3ca_-XRopq3IB8PjQVXe28Z977_lahBtkuWt9pRnOoIxjGkLGOOKPdA
    AARiSPGoZcS60fhBCrismBz7L1N8QwJQqwcHHsUbkMyuITrX30ESQ>
X-ME-Received: <xmr:IZdracbj0OI1aOsMiyu0gfOxX1nxsE_E3Kth2nLfNTSunZ6QFR--5G-B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufedvtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprg
    hulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihgrmhdrhhhofihlvght
    thesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvg
    htpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghj
    ohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoshhsih
    hnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:IZdraYeWzdXBE9kPyssInmWLbGA8iwajfVCx2oxQUM6U-hIMLDcGig>
    <xmx:IZdraZ42wspFqZGpXQUnVbheX2LO_6XSurzvC9TpAhWSxvpUEC-o-Q>
    <xmx:IZdraUV7RYKVtpHoF-AFz1HCozvEgqj6oinCJyqlrMJySPG3-4eecQ>
    <xmx:IZdraQY2Qny_odfRhMRMNKCg8lyLzt8VE5w2aFVGt4S3tZLeAjQRcg>
    <xmx:IZdraTz9htCnQ2MPeXJYz1qzKH63G2DuJZh3MtunPCOeHfzhUO2DmGIl>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Jan 2026 09:05:20 -0500 (EST)
Date: Sat, 17 Jan 2026 22:05:18 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Andrew Ballance <andrewjballance@gmail.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	rcu@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RFC 0/2] rcu box container for Rust + maple tree load_rcu
Message-ID: <aWuXHkGZlMvr0uxD@tardis-2.local>
References: <20260116-rcu-box-v1-0-38ebfbcd53f0@google.com>
 <aWrSkAPFkdH_tvtN@tardis-2.local>
 <aWt4muGXbe7lBmXt@google.com>
 <aWt8Ze-otTkexNIe@tardis-2.local>
 <aWuKlR4a-VJhBeWj@tardis-2.local>
 <aWuOtUa0mPDrnbke@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWuOtUa0mPDrnbke@google.com>

On Sat, Jan 17, 2026 at 01:29:25PM +0000, Alice Ryhl wrote:
> On Sat, Jan 17, 2026 at 09:11:49PM +0800, Boqun Feng wrote:
> > In Rcu + RcuOld design, RcuBox is just a Box
> > because these two pointer types handle reclaim + accesses.
> 
> How would that work? Dropping my RcuBox<_> must use kfree_rcu() or
> synchronize_rcu() or it is unsound. So it can't just be a Box.
> 

RcuOld<P: ForeignOwnable> will call synchronize_rcu() before dropping
`P`. And I think we can have an asynchronous drop pointer type like
`RcuOld<P, Async>` that requires `P` is a type like `Box<HasRcuHead>`,
and the drop of `RcuOld<Box<HasRcuHead>, Async>` would be `call_rcu()`
or `kfree_rcu()`.

Regards,
Boqun

> Alice
