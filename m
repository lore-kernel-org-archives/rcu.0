Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FD130E84F
	for <rcu@vger.kernel.org>; Thu,  2 Oct 2025 13:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411607; cv=none; b=u1NqSEDsDJS3aYH+8u0t2UI7gGCpfBEtkZ2/5h5GBdFmtzTLAi2csLVfaTamoc3Y9g14Ry9+JQ5t/ADGXLXl97Fju57+H7TwKe+pOo16yIZiCa6T1SP+alTJYFXg8cR2UP4iR/ArXtfGAAdkYc87kI0QEXZruAw8/zh0Gq7dynM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411607; c=relaxed/simple;
	bh=Bzm3UVzy5UmWZcilLMKv+UlC3Okbitce2Is02Gaxtrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n4dmWcKFNcLZIayvH96hW3HA8IRDmFDBdxmaN+pmaCJULusHglF+/cylwmzetiKZEFdPnllQDo1N1vlN68jzspOr2bxCaKPTFRPYbp0Q/VJAU51SPyG+v8sKNqRiTEcY9AWMMu7gI+z0DkEo13nTD/UAVNJUtwr7tZlUS2M9Eno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-858183680b4so143333985a.2
        for <rcu@vger.kernel.org>; Thu, 02 Oct 2025 06:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759411604; x=1760016404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ec+ndxQ3jnu1a8VNviNr06HkWUDsCBC6MfDIjOmWDIU=;
        b=GP0Ij/Q9sEOLwePQQzDGz2djepYCI1w2UD/6tQ45QCbuFB/eYGy9JDtVZIPbWPLMMe
         /KUXF14B62QrcFtdsXgq7QBX8+4VwfxUSFUqY05pw59t8/RrUjsP2O5DqazTrP7WMAAp
         uidmMq3XAnEeQFvjcss8PF3ibgMyVlKoXJ3zyAN5ETdXTNQtfkzQoogcWVvYarMuz4R4
         9uGphlZ7jvKX22tFHD7zI2r5A/u0C9L91oCDzfZi6cFM5YPXfibtfCZjTD/KHTydg9ZJ
         /3dsRIUBLZX9sguKYt54VV67vmiEVw+LT8ybPI1k/WrC77oVaZ5Io2tGms2GXaDZCfet
         rsZw==
X-Forwarded-Encrypted: i=1; AJvYcCWUbz8gOMLk7vm5tixsJOOP1hxaoXAOCsi1h7U1R7qzZd0JFjwkoKA7C2VyvKqkALm3ujE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc6KDtVj2WaxJPhlbBcIR0mIf241HqhwGMinc61Y880/VZqnf7
	68GwzLyKVuHNEc+FH1GmdoTrkQPI4ususCMHsqd2EfrD/j3hrpDzEmI717cEm/t3+uSD2A==
X-Gm-Gg: ASbGnctbUwSGe722yV32ew3aUiS12hIuhCsARpQ6FUYNQ+xhtZYHplg2xrZ5nbVMlSe
	czstHgbPVevnSoi5EpskRawrCdgcBwdjFOCVkmVETtnyWOIthZyHwH6GBJHGEyl/xEdkPcE2NR3
	3yo4dGD6rTUW/t1mobYWYhSVMe0/58QSLrcLEA5z7IH6B1yqYyPrwVTW8FT+QsPm3IU6anNtZ2f
	mHc6pDQ4jJcex7ZmP4kM+SI0v1nZcyHNThdMc/KAxHCxgyfotcvTT/yN8m+spJMwAppYFvWizBG
	RppeO7wR9If/+p8FZqFKsJtO0OcdZmW0ceeVVNDHhhyuaUAE807cO1AVL+LnfwJ5PH/M3VC4aOk
	R08Nfg8bx+VgB1+vdPuUDC4e9JVVWWs7y+KuO16pHk85QRYvj9VWQjctEd1XFwU0EBldaqZjZfA
	uGjXzhcoPak6ET
X-Google-Smtp-Source: AGHT+IHRyGdq//p8RW+MnSf3ZMIaUC+P6iAMyyYtOLE0Rk3lieMUNASIAFXdrUFmpXMAS6TRR8q3Dg==
X-Received: by 2002:a05:620a:288f:b0:864:4cb1:506e with SMTP id af79cd13be357-87372496a61mr987755485a.35.1759411604383;
        Thu, 02 Oct 2025 06:26:44 -0700 (PDT)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777865073esm213725685a.35.2025.10.02.06.26.44
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 06:26:44 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-858183680b4so143331585a.2
        for <rcu@vger.kernel.org>; Thu, 02 Oct 2025 06:26:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWk3kgBKm/7XnIzVj4EKPgWLKm5VXSxC//qSrVi74spVM5adp5ZOMUK8DWUf7uYlrt7G0=@vger.kernel.org
X-Received: by 2002:a67:f74a:0:b0:5d3:fecb:e4e8 with SMTP id
 ada2fe7eead31-5d3fecbe643mr2057033137.5.1759409779799; Thu, 02 Oct 2025
 05:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002081247.51255-1-byungchul@sk.com> <20251002081247.51255-3-byungchul@sk.com>
 <2025100255-tapestry-elite-31b0@gregkh>
In-Reply-To: <2025100255-tapestry-elite-31b0@gregkh>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Oct 2025 14:56:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWXuXh4SVu-ORghAqsZa7U6_mcW44++id9ioUm5Y4KTLw@mail.gmail.com>
X-Gm-Features: AS18NWCmqHU8DKNueQjpF6Ifrv2W5fzYfUTjQ8XBBt-1KrFWqeUHHsvmYo_0fpY
Message-ID: <CAMuHMdWXuXh4SVu-ORghAqsZa7U6_mcW44++id9ioUm5Y4KTLw@mail.gmail.com>
Subject: Re: [PATCH v17 02/47] dept: implement DEPT(DEPendency Tracker)
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org, kernel_team@skhynix.com, 
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com, 
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca, 
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org, 
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch, 
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu, 
	willy@infradead.org, david@fromorbit.com, amir73il@gmail.com, 
	kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org, 
	mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org, 
	vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, 
	cl@linux.com, penberg@kernel.org, rientjes@google.com, vbabka@suse.cz, 
	ngupta@vflare.org, linux-block@vger.kernel.org, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org, 
	dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org, 
	dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com, 
	melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com, 
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com, 
	max.byungchul.park@gmail.com, boqun.feng@gmail.com, longman@redhat.com, 
	yunseong.kim@ericsson.com, ysk@kzalloc.com, yeoreum.yun@arm.com, 
	netdev@vger.kernel.org, matthew.brost@intel.com, her0gyugyu@gmail.com, 
	corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org, 
	sumit.semwal@linaro.org, gustavo@padovan.org, christian.koenig@amd.com, 
	andi.shyti@kernel.org, arnd@arndb.de, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com, 
	mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	samitolvanen@google.com, paulmck@kernel.org, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org, 
	urezki@gmail.com, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	qiang.zhang@linux.dev, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, chuck.lever@oracle.com, neil@brown.name, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, 
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	mark.rutland@arm.com, ada.coupriediaz@arm.com, kristina.martsenko@arm.com, 
	wangkefeng.wang@huawei.com, broonie@kernel.org, kevin.brodsky@arm.com, 
	dwmw@amazon.co.uk, shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com, 
	yuzhao@google.com, baolin.wang@linux.alibaba.com, usamaarif642@gmail.com, 
	joel.granados@kernel.org, richard.weiyang@gmail.com, geert+renesas@glider.be, 
	tim.c.chen@linux.intel.com, linux@treblig.org, 
	alexander.shishkin@linux.intel.com, lillian@star-ark.net, 
	chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com, 
	link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org, brauner@kernel.org, 
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com, 
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Thu, 2 Oct 2025 at 10:25, Greg KH <gregkh@linuxfoundation.org> wrote:
> > @@ -0,0 +1,446 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * DEPT(DEPendency Tracker) - runtime dependency tracker
> > + *
> > + * Started by Byungchul Park <max.byungchul.park@gmail.com>:
> > + *
> > + *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
> > + *  Copyright (c) 2024 SK hynix, Inc., Byungchul Park
>
> Nit, it's now 2025 :)

The last non-trivial change to this file was between the last version
posted in 2024 (v14) and the first version posted in 2025 (v15),
so 2024 doesn't sound that off to me.
You are not supposed to bump the copyright year when republishing
without any actual changes.  It is meant to be the work=E2=80=99s first yea=
r
of publication.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
