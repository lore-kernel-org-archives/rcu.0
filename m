Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436D516DEBB;
	Fri, 27 Sep 2024 04:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727411968; cv=none; b=PuQgbmZTgoeSJmb4xK0qsJahZipnzZ0TcdoIJ3C0DoHwuf5Gybo3e86xU8acXQ0ou5QHvDz2ZIRzDAyaagIqNIlBSjmulqLepirirs5Z1c9+7l3bcmu8DxelhmxjvMBA86e0jEEFTip+FgowjJR7qN95H+soD8LV0bbr0/swrlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727411968; c=relaxed/simple;
	bh=w6DVDQjkuNJHV2tR9GWVHMeZWBXK08jPVFfyVvSYekU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqvCoN25+VUAUBVOSY2WaXqT6wJqelsjt991C9vK2Oa9IlWi+HYglJlQPAiP56nQsmVYPaAdSBzX02A1CinqtA+rk9XB9veffdhFvBXxDafY5XImIyWagOnFRUI4/RT1K4GacZJnbsR2Oy0J7/RVJp9niipjvGb3GNjX6WNqhzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmZXZfde; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmZXZfde"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4582760b79cso8731941cf.2;
        Thu, 26 Sep 2024 21:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727411966; x=1728016766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRU6/4TVUAhjoio/t/k6qqSqdEw/5cr8n1FQhHvr5Jw=;
        b=RmZXZfde9kQ6JsiHhTKwR3YW/yxDWN4wIFGj3WKFYIgtXiDEzYTzNwd5mCfTq8DKUe
         qfqsod6cqWd0ieZ/8b4RpGhjwfD6ifufstB/DPbRmbUj6DqG9Njrfk7kZBEH3P36zZGP
         XTk6M9Bn2jb6KLcob8aXxCR0BsDH4g0xkdqKGa+orHlJ9nsodPAzfISakntHjQ3TV5us
         cT2te/soKM5JuhfZXaNu6cFXdfbBLNFBFip/l8mOP0DbR5gDJoZBkhqK/cTwKmJYnvjg
         g8yZVV3bmajdP4ywvhh9VW0dQpMi1diX2F5t1RAu/zgVcEgEkfBQCH/W4F83d3+cHxhq
         mOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727411966; x=1728016766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRU6/4TVUAhjoio/t/k6qqSqdEw/5cr8n1FQhHvr5Jw=;
        b=MRUhBctwzcgZvtEP190qcIOeGc+wnaLWD0Zs/UWrvBbvRhWdVNcLseONJ2464UGCS4
         cRVrJ5NoKiuWVMm4kk8BgHucXQOGY1bzqWK+7+ZraTVAl8b0nrPAL669emQ+TXdMFgqq
         ma8x3DA3l3N8S/EToxx0w4dEw8qn9l9vjakskpBZHLIczaMomK4cLchJoIhUMlpgzZIs
         a0Sg9gYmP4nj2Dy/iIDWTgK9DM5NxE4UCMpekxBLHTA3yqi5ek+h/zIm6V1SYCOglnyK
         0Lb2lYj/2hl1o0/H+zJD1yKY5FTnCAdduv1Y8Yn1zBZCNwXcG2MmeWUpjxfb4hetFZ7g
         s/ow==
X-Forwarded-Encrypted: i=1; AJvYcCWeXSse3soI+A8fV2C8VeFEcrsmSpW7yE2HZ6gvBEMrrUdkZPcO+wUor3BKS+XoY114ND3Q@vger.kernel.org, AJvYcCWvoGPEhWwulQdCKKqKXSrCR+gh2ZH2CO7sE6MOpUyvaYk/A1bjarBUcPM9ZVILzaARpj73hDCH5cL48IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbK8XgXewxG5Yp3NXNaTcVEn92EpjmIA2WMwnWgXzhzFGKjkwp
	FK3uK61bJz3EnkKzM9YIkdVW3ktk2NZqXtNsVvTJTTSSrP/F4/b3
X-Google-Smtp-Source: AGHT+IGRJNR8YMG45DUkKzLpm66mQWZjHJK0giSYGof1EtZOJwSea9/ISL5wW4ohXqjOGHnxmP/MAA==
X-Received: by 2002:a05:622a:3c6:b0:458:4fe5:b2f7 with SMTP id d75a77b69052e-45c9f1afb2dmr27273301cf.5.1727411965976;
        Thu, 26 Sep 2024 21:39:25 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f33a4c9sm4743071cf.73.2024.09.26.21.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 21:39:25 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id F372C1200043;
	Fri, 27 Sep 2024 00:39:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 27 Sep 2024 00:39:25 -0400
X-ME-Sender: <xms:_Db2Zkk_zmSebOfd8O1C0dPjWEHeAc3XgIa7MGu-fQ_2TfzAqj73ug>
    <xme:_Db2Zj2k7iVcRTB8aHCcinbmRlJKf27pwiY-9PsIpQpUTXvly-upYBVT0KRm3Ik6_
    f3XDotMKSTX0SJk8Q>
X-ME-Received: <xmr:_Db2ZioUx9N0ctlCUE1izEehr-fygmlBkkfn6jhGcf1Y-R-XLkuXTBytIR8lrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtkedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhsse
    gvfhhfihgtihhoshdrtghomhdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidq
    fhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepjhhonhgrshdrohgsvghrhhgruh
    hsvghrsehhuhgrfigvihgtlhhouhgurdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdr
    ohhrghdprhgtphhtthhopehlkhhmmheslhhishhtshdrlhhinhhugidruggvvhdprhgtph
    htthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgvuggv
    rhhitgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_Db2Zgm-fE8hUMqHcNrwexhGyjRt8C6pMc4co2W-LVb-0PvCIjUHgQ>
    <xmx:_Db2Zi3EaCVb2yT79AagRK1gPp6JkGM2Q4yorZ7HOy-59UQpgt_PrQ>
    <xmx:_Db2ZnuRPm7ueXHyIKmUrw_sSK1EPmRfIKoFu0cKk1lqqPl2F4VOsQ>
    <xmx:_Db2ZuUEWmG_uNpKv8Nlf5VYrJZPJLQo8ehdYpnsYKh5SYdlD-MGgQ>
    <xmx:_Db2Zl2ghnXP6pi4SS_g5elLYJbdgdUI3qv93e4On4PdGEs2n0WR-gAC>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Sep 2024 00:39:24 -0400 (EDT)
Date: Thu, 26 Sep 2024 21:38:36 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	linux-mm@kvack.org, lkmm@lists.linux.dev,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
Message-ID: <ZvY2zBiluLkqRSkc@boqun-archlinux>
References: <ZvPp4taB9uu__oSQ@boqun-archlinux>
 <4167e6f5-4ff9-4aaa-915e-c1e692ac785a@efficios.com>
 <ZvP_H_R43bXpmkMS@boqun-archlinux>
 <a87040be-890b-4e83-86bb-5018da4a894d@efficios.com>
 <48992c9f-6c61-4716-977c-66e946adb399@efficios.com>
 <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com>
 <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com>
 <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com>
 <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
 <bba2e656-4c3b-46db-b308-483de440b922@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bba2e656-4c3b-46db-b308-483de440b922@efficios.com>

On Fri, Sep 27, 2024 at 03:20:40AM +0200, Mathieu Desnoyers wrote:
> On 2024-09-26 18:12, Linus Torvalds wrote:
> > On Thu, 26 Sept 2024 at 08:54, Jonas Oberhauser
> > <jonas.oberhauser@huaweicloud.com> wrote:
> > > 
> > > No, the issue introduced by the compiler optimization (or by your
> > > original patch) is that the CPU can speculatively load from the first
> > > pointer as soon as it has completed the load of that pointer:
> > 
> > You mean the compiler can do it. The inline asm has no impact on what
> > the CPU does. The conditional isn't a barrier for the actual hardware.
> > But once the compiler doesn't try to do it, the data dependency on the
> > address does end up being an ordering constraint on the hardware too
> > (I'm happy to say that I haven't heard from the crazies that want
> > value prediction in a long time).
> > 
> > Just use a barrier.  Or make sure to use the proper ordered memory
> > accesses when possible. Don't use an inline asm for the compare - we
> > don't even have anything insane like that as a portable helper, and we
> > shouldn't have it.
> 
> How does the compiler barrier help in any way here ?
> 
> I am concerned about the compiler SSA GVN (Global Value Numbering)
> optimizations, and I don't think a compiler barrier solves anything.
> (or I'm missing something obvious)

I think you're right, a compiler barrier doesn't help here:

	head = READ_ONCE(p);
	smp_mb();
	WRITE_ONCE(*slot, head);

	ptr = READ_ONCE(p);
	if (ptr != head) {
		...
	} else {
		barrier();
		return ptr;
	}

compilers can replace 'ptr' with 'head' because of the equality, and
even putting barrier() here cannot prevent compiler to rewrite the else
branch into:

	else {
		barrier();
		return head;
	}

because that's just using a different register, unrelated to memory
accesses.

Jonas, am I missing something subtle? Or this is different than what you
proposed?

Regards,
Boqun

> 
> I was concerned about the suggestion from Jonas to use "node2"
> rather than "node" after the equality check as a way to ensure
> the intended register is used to return the pointer, because after
> the SSA GVN optimization pass, AFAIU this won't help in any way.
> I have a set of examples below that show gcc use the result of the
> first load, and clang use the result of the second load (on
> both x86-64 and aarch64). Likewise when a load-acquire is used as
> second load, which I find odd. Hopefully mixing this optimization
> from gcc with speculation still abide by the memory model.
> 
> Only the asm goto approach ensures that gcc uses the result from
> the second load.
> 
[...]
