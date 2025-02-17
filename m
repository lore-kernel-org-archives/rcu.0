Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED885C8FE;
	Mon, 17 Feb 2025 02:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739759719; cv=none; b=h7sQ7T8P9DSFR7in4AftEM8Ykw0qXmm40SH2RKYOIlaiMlQiIUBh/Mvpc1hiohDso2FRNCbMA0g4ljNO/Xuurl2Jd4obnn84TlggT/6poH2WAzqmyoAI9sTOBPVaOcV9aZP0Dk/WHGcSIjz2zNPKXXoFCclJjnv4OKnWpOuR308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739759719; c=relaxed/simple;
	bh=I+O7baQFbEf1IyCFpkV0h5+2IhECP2e39YhlPgeAjf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8sGFZudivUk4FcbRhn4hufhPv3gSqfDIN7jk+0kCfMz3CXPOWzaZzm9x+wgoz60tIOc9hoj2U7zz0wO7stlet5tMvC3CtMeiW8n+uidwA8Xth69CCE8B99YOrA5SkHhyS5B3CnSd7R0VzqMeacKWG++PwgiR8cTASHFt9aR0Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPxjKfj6; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPxjKfj6"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-471e4ac2f85so13195371cf.2;
        Sun, 16 Feb 2025 18:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739759715; x=1740364515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=815sjY3wqJSzJc1Kv8wqZ84KA2u8Z/2kVQQOVqwSOKk=;
        b=nPxjKfj6HAa9XDpiVZO2V1muyQYa3h8VTNzpl2+BSZ5vaO1b84yuPbYH/cYyr7Jm8f
         sUplqTMm7A8To3w/qk+jwZpXEJ5OX8SiPYftd9T0C0boWmZUSufV4tsUbp8FNyGBNHRG
         OmAL58f2OSZGAhFM+fyeB5Jc8U2CFbPostq+rTUG4FwNKvTOXUtyVoHanJIy5xLw6o1n
         CYLv3+YSp4lzvoyO3qTnRvW1EcL9t9aN47dp93CjxLN+8Sk54zLGH1v97/UfPh9+3a4r
         yPuthAP6Ln6RjL7hMcTgO/F8skqv0PBH8yVS++hJaL0MdorOSiQxY6rksayqjgXWfWNS
         ZPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739759715; x=1740364515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=815sjY3wqJSzJc1Kv8wqZ84KA2u8Z/2kVQQOVqwSOKk=;
        b=eX+3ram8XlM7Ws+ySLYzOUJZgRXheLkZyuTpfv6NF0HwIXD2yOLlisSRFoIqlGYzDw
         LiPhChRily8z5OKAxp54mwgt9bvpfY/zl4zerZ3GBkTTE1KP1VHP/DBou3li4dibBVmf
         GLfTQKDj6pVs0dEz44qwZJVhllErjuCEItFbskkuWzYXOSiIOAOVFhU+IiErI6I9Hy9D
         P5+dDbsWyR7U2koYeF419lOkNJTrDm6qikDka6Bbg6W72J+5PgCjPoDzAyCr1oAnIVWX
         Ry8JIoQtRW3gMja9uQNlj+tT7I9smW+1ert8UpRlm/Vfx9bOgua016LeBMo0rrG8rAN9
         bDYw==
X-Forwarded-Encrypted: i=1; AJvYcCUrnCPEfAI5KAWHqcKdpDC/HKnHDTpAdthLHtW9n70M4yWRmPKkrlZo9N/HbTV/e81p4VDzLvGlUN8=@vger.kernel.org, AJvYcCVv61aej2uOdYUPIaZJQh8zgjKwWIh3YLnJh9XJ05Yuhx5uyezrxZaPEjC1DenSM23YL7vU@vger.kernel.org
X-Gm-Message-State: AOJu0YxNQBUwga2ZvuMZ1LdbspdU4mBf0EC8bzK5cu1kFiajB/c11TKs
	kTACV3P7MJRLfNffGi2Dr90tpWrk+B9l4ge8p3IHpI/fVwyaxiew
X-Gm-Gg: ASbGncuxy1a9vd5Fx8/hjNfqAGfE/NagVxMzZ8okfr2w9VBn4Tu9uryCiZZ8jsLTkJc
	OYtvNHzw3U1jq1Mam1NhKjTyh3bHz6CU2ev5IRxJrDCtcrMRffi+0NU/VNGtP2YaL7evrZowZvW
	WxZXmuS5u9h1M8MKkNNxHxNttrRYkNaOwhmpkHde3i9lU33DPbWIU+73EIAwLiS71TEQ5BF+YkZ
	ItrpmS4KU18J2D4QgBFXgrVrN6+SvjkSI0hEsYKtDpKmpZja898ZXhfHCoFtOMSDSSqwVVjZ+pA
	vOdg8gHdo/FIO7Oze/v/VMEEKY70mPRIeGGz3PsBkXo32mQ14ZQKi4YwOgpD+LJVXZDcgazozBV
	IhlhrBw==
X-Google-Smtp-Source: AGHT+IHtmpaJXk/4LMB5mqRLERnyI++fWV4xzmhjO60fI5UXv1kqX+vioG9OYu00/XQKtwL7T0GUcA==
X-Received: by 2002:a05:622a:28a:b0:471:d67d:fe54 with SMTP id d75a77b69052e-471dbe9fc70mr121066611cf.49.1739759714741;
        Sun, 16 Feb 2025 18:35:14 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471ea7af88fsm9840941cf.69.2025.02.16.18.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 18:35:14 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id DB3471200043;
	Sun, 16 Feb 2025 21:35:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 16 Feb 2025 21:35:13 -0500
X-ME-Sender: <xms:YaCyZzEd8F_0ddYBuqAkjN2uG2s4GJ1xXKiSziD0QGoyieqBsVZ18w>
    <xme:YaCyZwWQmELNx1nPV52iCG86nI1wPjaS0YBPIj5WVNpCgYprXWZ-JamCbp6lUIENa
    jaqjxj2CjMyIoWBmQ>
X-ME-Received: <xmr:YaCyZ1IoVn43KHIO3B_lmtElQ44crOUfr2jM4-vJ0YxInLpsKzibW_B8Qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehjedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdet
    heduudejvdektdekfeegvddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epmhhmphhgohhurhhiuggvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhitghhrghr
    ugdrfigvihihrghnghesghhmrghilhdrtghomhdprhgtphhtthhopehprghulhhmtghkse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrughhhigrhieskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsg
    hoqhhunhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:YaCyZxFDZL_UizEY4pzLskBrjOS23IEvy6pSsdm7ZcVyCeaUS9FUIw>
    <xmx:YaCyZ5WY4V8Xrj8tRPg0z-xT2oiq9GVxVVP7un6WzXwy_fZD7lj37w>
    <xmx:YaCyZ8NxZuIsF-CjtSL6zZcA-smVbXw6B4dhfQ0dXYhKg_9SwLKaXA>
    <xmx:YaCyZ40zNdx01V7zo5JZq9wpSHhsR2hs8bLriu9GT3rHzyZVrW8kdw>
    <xmx:YaCyZ-VtpGPSFtrs8JWF6pGxz-gggp37k6T-3HIVzheGBW_wAfvtKr3Q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Feb 2025 21:35:13 -0500 (EST)
Date: Sun, 16 Feb 2025 18:35:12 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alan Huang <mmpgouride@gmail.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, paulmck@kernel.org,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	rcu@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc/RCU/listRCU: fix an example code snippets
Message-ID: <Z7KgYN8itEhw2Ki8@Mac.home>
References: <20250101082306.10404-1-richard.weiyang@gmail.com>
 <Z7Ka8Z5RS_OwyL_G@Mac.home>
 <CDB3A2E0-A891-491E-9F7D-F09843F1A3E3@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CDB3A2E0-A891-491E-9F7D-F09843F1A3E3@gmail.com>

On Mon, Feb 17, 2025 at 10:22:53AM +0800, Alan Huang wrote:
> On Feb 17, 2025, at 10:12, Boqun Feng <boqun.feng@gmail.com> wrote:
> > 
> > Hi Wei,
> > 
> > The change loosk good to me, thanks!
> > 
> > I queued the patch for futher reviews and tests with some changes in the
> > commit log (for title formating and a bit more explanation), please see
> > below.
> > 
> > Regards,
> > Boqun
> > 
> > On Wed, Jan 01, 2025 at 08:23:06AM +0000, Wei Yang wrote:
> >> The example code for "Eliminating Stale Data" looks not correct:
> >> 
> >>  * rcu_read_unlock() should put after kstrdup()
> >>  * spin_unlock() should be called before return
> >> 
> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> > [...]
> > 
> > 
> > ------------------>8
> > Subject: [PATCH] doc/RCU/listRCU: Fix an example code snippets
> > 
> > The example code for "Eliminating Stale Data" looks not correct:
> > 
> > * rcu_read_unlock() should put after kstrdup(), because otherwise
> > entry may get freed while kstrdup() is being called.
> > 
> > * spin_unlock() should be called before return, otherwise the
> > function would return with the lock of the entry held.
> > 
> > Hence fix these.
> > 
> > Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> > Link: https://lore.kernel.org/r/20250101082306.10404-1-richard.weiyang@gmail.com
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> > Documentation/RCU/listRCU.rst | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
> > index ed5c9d8c9afe..8df50fcd69fd 100644
> > --- a/Documentation/RCU/listRCU.rst
> > +++ b/Documentation/RCU/listRCU.rst
> > @@ -348,9 +348,10 @@ to accomplish this would be to add a ``deleted`` flag and a ``lock`` spinlock to
> > rcu_read_unlock();
> > return AUDIT_BUILD_CONTEXT;
> > }
> > - rcu_read_unlock();
> > if (state == AUDIT_STATE_RECORD)
> > *key = kstrdup(e->rule.filterkey, GFP_ATOMIC);
> > + spin_unlock(&e->lock);
> 
> According to the above quick quiz, we should return with the lock held.
> 

Good catch! I think we then don't need this patch? Wei, are you able to
confirm Alan's reasoning here?

Regards,
Boqun

> > + rcu_read_unlock();
> > return state;
> > }
> > }
> > -- 
> > 
> 
