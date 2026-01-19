Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A68E1E9B1A
	for <rcu@vger.kernel.org>; Mon, 19 Jan 2026 02:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768790335; cv=none; b=O9MB5xouz3BrFJnI192j7rgVKtvdVKG0sFrKgffogUaUIzE8klQZ6xu/qa5pxatECIrIp7qvCp7jm9X3FdcvHK7seMg5FYb5/vTI3O4ToEbmas2LhbS48OOYiQxeRKzjaEC1aVa9H29aq363iau1bVWS0EpfKNXvhin9+/q8Oes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768790335; c=relaxed/simple;
	bh=7ieh8bpu/47zcDqVpa34kh7zmCuxOI0aSkL/DkYVjeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRBqKuXLdKkVD/7hiHbLG0MPxKF7q1yvUbsWNAhIKsk4bVzNqkOt721M/jiZWQFJuM2eXDp/tgOzKVHeHEa9+kZTyrjE6swNjuAWZ8s5zt8KoXA32G0d05mfYAtrhj3xS7sg4jm276iGVKwWWUXHZfyYAyWwUVAZNnRVKgy7yuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHMBREr/; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHMBREr/"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b6bb644e8eso5329805eec.1
        for <rcu@vger.kernel.org>; Sun, 18 Jan 2026 18:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768790333; x=1769395133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fakORZHhU3LeknzGhGkh3JKvyYcqGqj2ajx5hHN4E8Q=;
        b=cHMBREr/yTSPPCRdspzCJ0uEjoNBtzODxF5AoDBmeHtTDbqH29qsBI5cGk1MKm1QZl
         WIU3TqrnSMY0X4MWXniZldo3VMN2uTs4DgBJBC27z4+ams5odHC5i3V0JdUzqOR9u6Lm
         +Pl4s0P3LBwrukQSYZsg0oT9/Xl1jrH2rmRbCSZPOjB5NjLlufupoNdGOwv4WADVHTGm
         KhBQkERWiYT+4j/UNZsnKe0dVMfGNxGATlAprsSk2M302pxxdRjMEULr5hvBHj5GOCmj
         fw8S71VdVaEF9cu0wu717mHld/eOFZhdoE7hX7dAOfk2TjzccRNrSUHezn2iaViKhDcp
         6GZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768790333; x=1769395133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fakORZHhU3LeknzGhGkh3JKvyYcqGqj2ajx5hHN4E8Q=;
        b=h642auXYuq2hWtWTN5j36mEXaGP8a/PNk+cJiu8B4Nc/ciy8d4ZnHARzzsi0OUPs3V
         CLlUnnwS/XorE6N5/+vmwlIUbEDUWaA7f3L8IRVpmbD7xWPhNfy3tsTVGD0PkNEM9c5D
         JZb9ngfWFYq/25q/4JxH9ZWlG/WhDjyAQzDbFTmrxRTHC2J/s4+O2hS0ZzKxGUQA/NXZ
         i0LVJo5gG2pAw8jPCrY6DrgB5yMKLX2q9Zj6OGQHvCUUZNhbWr7Gn5Dbjs+CvlXLbE3W
         SQQrqsgpGOdiXjarvCdMylTxjSDG1rgcq3Hr0iisNG/Qz5zybg3oX1UbTuRA6AFtrZCC
         6H8A==
X-Forwarded-Encrypted: i=1; AJvYcCUltuCj1IbLhsq4GcxidVYa8itEBN1e1zb7y43ihw/DL+yTc1XbCNt9myuWzOM73AFrUCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYoGIyJ2JG9KOo/zE0FM9D99KbjWarrZEuiqUk43l6IXwRFMCm
	/xx7fDnj+NSmhtRkx8Amdw6ROQS4rBsWrAjmIdmPTIKHp1SP0VSyidcFkIKLrvNQ
X-Gm-Gg: AY/fxX5rpEBRR8+9qUBOs6qPhnNeWSSFZ/aNY6u126oa6s+/6UFcwky4380LSonIsjZ
	PcKtn9TEy2Z+YEYf2fk4IBEzUklsPOeC86F4dsQSCDNU/HUoy/tzUWh5PnmHrg08cI5XShGq/Wy
	wzaM80HVgzuGYGcUZUM2klBMpvKQfzSk879W9udX2SL5G/fU8teTGgY2s6b2y5PkqNIYe+yvxBA
	Jc37xEZuxnvFSAs7Q80PgWwUzErJxjVxJWmz9Yfa8h9O76Ex9RnFFp0k+KIc5s1tRVi76YpNkfm
	B8sFM7ATAxjPQ28XURCpqCZ2wJD6dgl7hXKPljLxqAk0JH97DuWKUJWe+JrExmF1br4OpLNhN3s
	dG3y9Vv+oEkpVZPWPiLiKwAViDDlE5aqFxYqClpV87tiZvZT6VOO5aPNjPXUguoXgg+7FhFcic3
	5WmD+YNSyaD797MGBuqmAhlbA0hWwMd/UFhI4l+OmZMQRCBFiQ3X6oG0VEfSpBlmWwSsYXtgrUf
	wD4N0sleNzUTEU=
X-Received: by 2002:a05:620a:45ab:b0:8c3:87eb:f with SMTP id af79cd13be357-8c6a676dd5amr1306466485a.53.1768784635960;
        Sun, 18 Jan 2026 17:03:55 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a72985a8sm693681085a.54.2026.01.18.17.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:03:55 -0800 (PST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id D45BCF40071;
	Sun, 18 Jan 2026 20:03:54 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 18 Jan 2026 20:03:54 -0500
X-ME-Sender: <xms:-oJtae_2LWg9BXW9ZSw9oURJdYOziSn_fFRlbzJiPDr9o8e3XnMGVA>
    <xme:-oJtacIjm-BjxKHSekluSgTHtvg-oW4gE2jtJLDnACDTJZglzS90jHoDE4HYGYP6B
    p8NcGtG-g3zOuf7KvwK4f25Bz1_UO2Vt0gd8UmsQLTk9I3cfyRK7g>
X-ME-Received: <xmr:-oJtaT9BV1WGQLx-cxULml31pE2GyW-I7kXgYoExwyhGysVXHsj4k9VD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeeivddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepvdejpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopeguihhrkhdrsggvhhhmvgesghhmrghilhdrtghomhdprhgtphhtthhopehruh
    hsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpd
    hrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghp
    thhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrdhhihhnug
    gsohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-oJtaYH6He1PzPkL3M28LoSg-zlXbIctO9_n70CJ1d0RAKSX2gLBzA>
    <xmx:-oJtaTPng9w2VrRzYJtXT-gluuZx33z5t4xoyAfil2-OXIxdnd-wSA>
    <xmx:-oJtaXR0Q7SzfP8yxgG-mGy4kl5BzerW16D7vVKu0GY7CksfMt9zkA>
    <xmx:-oJtaaQ2GpheT3l-2fELAwR6kwSHCsXGjr-6cxYLZQSdFwG7aQkUOA>
    <xmx:-oJtaRb7fysrKnC_zWxrewj5MoO6wd0t6p2o80Deq31Qlf62JcSjFhRC>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Jan 2026 20:03:54 -0500 (EST)
Date: Mon, 19 Jan 2026 09:03:52 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Dirk Behme <dirk.behme@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
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
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: Re: [PATCH 5/5] rust: sync: rcu: Add RCU protected pointer
Message-ID: <aW2C-A5a7gfNENcb@tardis-2.local>
References: <20260117122243.24404-1-boqun.feng@gmail.com>
 <20260117122243.24404-6-boqun.feng@gmail.com>
 <56d1cc0e-df60-4e2b-bfa9-b29ec48a76b6@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56d1cc0e-df60-4e2b-bfa9-b29ec48a76b6@gmail.com>

On Sun, Jan 18, 2026 at 09:28:35AM +0100, Dirk Behme wrote:
[...]
> > +    /// ```
> > +    pub fn dereference<'rcu>(&self, _rcu_guard: &'rcu Guard) -> Option<P::Borrowed<'rcu>> {
> > +        // Ordering: Address dependency pairs with the `store(Release)` in copy_update().
> > +        let ptr = self.as_atomic().load(Relaxed);
> > +
> > +        if !ptr.is_null() {
> > +            // SAFETY:
> 
> 
> Would it be an option to take an early return here and with this drop
> one indentation level of the larger `SAFETY` comment?
> 
> if ptr.is_null() {
>    return None;
> }
> 
> // SAFETY:
> ...
> Some(unsafe { P::borrow(ptr) })
> 
> Same for `Drop for Rcu<P>` below.
> 
> 

Make sense.

> > +            // - Since `ptr` is not null, so it has to be a return value of `P::into_foreign()`.
> > +            // - The returned `Borrowed<'rcu>` cannot outlive the RCU Guar, this guarantees the
> 
> Guar -> Guard
> 

Fixed! Thank you!

Regards,
Boqun
