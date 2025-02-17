Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC1F76026;
	Mon, 17 Feb 2025 02:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739758326; cv=none; b=Vu3P5R9VuNlQXgstN54VISsxKSEiR1PHT3qynRStEykqQqacS0udwamCEL3Bcme4c1AK6TvygkC8/gJbomle45Y4JJbhOAQtaDADCuVs9ygsXaJldljVpcFn30gRQerRn5d4pQJzReSxI7uKK3RRz7vsqXZXU/tlhbRv/WIikJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739758326; c=relaxed/simple;
	bh=NLdFO27qpvN8zY+dJVhvFtamOsv39cjJjxxbReiO60M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAO19PC1J1AR1pXPi8tDwW+fmgRowV/5UQlnWGJOuKiA6XuwA4jBESJjY+pRb+qt1AINP6s0VORi7U6/JB907SpKxKFjqaQeiNli+kH7zI8jqM50Au5BzCQbgdlsy0V/3BKm7eqIzgTalICmqkkDgeFsruYzz4pLd2+74SLpXrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A01Oz1k6; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A01Oz1k6"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-471ebfbad4dso6189991cf.3;
        Sun, 16 Feb 2025 18:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739758323; x=1740363123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYMzkjPFhu4j+/htejHxz0Ece5HFcsbyGIeX6/xhquU=;
        b=A01Oz1k6PRxeD7w7OB89uNi7O+yxznbNDvCBUlvENqO2oeeqJYqZdkz/aWGKxl7Zb6
         97AetXdsa7L0tsSJr5y1p66tIXxO0HFucSEl+KtORdGuPvEQIDwCdgxOPkldUTqxcPjK
         11O3+gFDowV7RO9TvIwvhCBBJEslrGa7bxoLtEiXY2o5X6tLJNVvLBQ7R5GTzo89vQUK
         W6+hgxAucUbfv9rhNqegYXGqC/mzMWrfr71CPGD8WlFeKLNuIYnvIZYi+d2/VBnMajF9
         624m7mElRsLzujxuKCuN8TAWp/z0/vXnyhEgP4PU/lIR/mar4uqBll0wgc7hvoHc9seR
         Qjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739758324; x=1740363124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYMzkjPFhu4j+/htejHxz0Ece5HFcsbyGIeX6/xhquU=;
        b=nJEOHxgWS0X7dWr+xfKtJkeEmfxl2Fmb2HI0RRhOg7snEQYPK80wCZlzX9dkldGF5p
         vPZlgG73HgkzCeK4RRCWTGaPbGz8wpi0WfpCkEQfY64Mp54uDwAMdyHSGcAKeRGycs9m
         Oz+vAoqI/CDKa8pqhmU5/wV4AqocSjcxFZeJbS9LXDBzsqf7tsYYdEUkeaXY8+P7fE+F
         8sHutTnmRwaIbNPuRDcWNo7egPyixp4kDahGJSaufeD715il4Xrnm0GCBwtwPdlyhzjo
         Fd9ngn0PAl9vM1PRK+/WlNiS5q8f+JRU/rwhXqcpcj/fNjzznYcjdVv/T4mbP64zMGPe
         jR6A==
X-Forwarded-Encrypted: i=1; AJvYcCW0lu7Q1bKxpG3cPoZ/hAdOys/9V7yYNPM5Dvtr2hCad3IZTXfAwMa7rVAU98MTo9sfMl7LNZeVOGI=@vger.kernel.org, AJvYcCWAX0LeB6I49ousOsp2xGKE+xEyS++5vpIjPBLLRG/KRgddcRqNyu3f8yHhjrGAWG8O5MMM@vger.kernel.org
X-Gm-Message-State: AOJu0YyPh7jWKJIM7lU6UA9ogE7+YZzrMx27asnMwd4cNVPJh2yBRLYq
	aB0JiTE5dnncqADDUwR7paum4889KJw6R2sKm6ASMmXdbsBBZm6w
X-Gm-Gg: ASbGncuipf/GJrj4J/N8jtJnhWJ4UFrrFnRlg92KnoQgUJ8W1izrbVPMlSZF/eIx0D6
	/DTBKw1qHK3XhmiKhSv84ZxRCurasMef3V+m4xJFewwwDmEiuvOxOfpD7NJJ5lJSDPn23reMD8S
	SKMQOCURRjHdQTQg4KTng5ov4TS1WmlDerCr+au3yan34Jt3tVYeXYqQm+Ykmh+/MUKir9EZs4Z
	vAkB2Nyh0uzbJcMtHAyQNVk01AXMhQibvcmfDYD69n8KqllKXMe1h4EKoCErpQGUqCM9Yrr3sGl
	afH3AqZS8ySJEqdIdD+qefXLRo3hmMWETcAFs/hl1NDDv0eDICz2VZSPtKxV7JDik6u7o7aBOC9
	PFHTEsg==
X-Google-Smtp-Source: AGHT+IFfbD1+PJvXob7XWwUPy/dDfSQ1gVpMkghQ7JLkctIDDG2P+iW941sWCzv/RMKHJXsCMOOmjg==
X-Received: by 2002:ac8:7d01:0:b0:471:bd5e:d5dd with SMTP id d75a77b69052e-471dbd274a6mr100097421cf.16.1739758323607;
        Sun, 16 Feb 2025 18:12:03 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c29eb0e4sm41972921cf.10.2025.02.16.18.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 18:12:03 -0800 (PST)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id EBE2B1200043;
	Sun, 16 Feb 2025 21:12:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sun, 16 Feb 2025 21:12:02 -0500
X-ME-Sender: <xms:8pqyZ8YxbWwRHOSZpBzQrVZLO2LyfbhwIqo6lvd6ntWlPaqLlkUdJg>
    <xme:8pqyZ3YxtCNj_f1J5wUXhwmrCYnY_LoRnYb6dU3cWnQhIj63QXSVwhrSO1sDjkKgW
    I4YDJusvNZI-nuqEA>
X-ME-Received: <xmr:8pqyZ29rUfwC4yJxEB1jXlQRD67TACaWNuPJVGZl5-7aSgW_X14HI6xSwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehjeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdet
    heduudejvdektdekfeegvddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eprhhitghhrghrugdrfigvihihrghnghesghhmrghilhdrtghomhdprhgtphhtthhopehp
    rghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgvuggvrhhitgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrughhhigrhieskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepsghoqhhunhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:8pqyZ2rkZyawUAtRCcCDe3mHvoH42RO_FqWsN6iecQ7oQQvdw0dlyg>
    <xmx:8pqyZ3pBb2tBuBxLtZ2wmmQowB1Rn4pxQ47CKIYfoPBJN9aThMHQGw>
    <xmx:8pqyZ0QZkVzsaaKcMAz_rFxPD-z0xsC6yMUdXxMsJVfXV9vJVsg5fQ>
    <xmx:8pqyZ3pryHt-ixXIl9Ec4nPjDEkzlr78ImsN2CZqnKdzZfTW_vr-RQ>
    <xmx:8pqyZ84rDq6SZJpTp2T7Ov5MTDAcEIeEaIb17FnhXy17pI6Cfia0kqd_>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Feb 2025 21:12:02 -0500 (EST)
Date: Sun, 16 Feb 2025 18:12:01 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	rcu@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc/RCU/listRCU: fix an example code snippets
Message-ID: <Z7Ka8Z5RS_OwyL_G@Mac.home>
References: <20250101082306.10404-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250101082306.10404-1-richard.weiyang@gmail.com>

Hi Wei,

The change loosk good to me, thanks!

I queued the patch for futher reviews and tests with some changes in the
commit log (for title formating and a bit more explanation), please see
below.

Regards,
Boqun

On Wed, Jan 01, 2025 at 08:23:06AM +0000, Wei Yang wrote:
> The example code for "Eliminating Stale Data" looks not correct:
> 
>   * rcu_read_unlock() should put after kstrdup()
>   * spin_unlock() should be called before return
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
[...]


------------------>8
Subject: [PATCH] doc/RCU/listRCU: Fix an example code snippets

The example code for "Eliminating Stale Data" looks not correct:

*	rcu_read_unlock() should put after kstrdup(), because otherwise
	entry may get freed while kstrdup() is being called.

*	spin_unlock() should be called before return, otherwise the
	function would return with the lock of the entry held.

Hence fix these.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Link: https://lore.kernel.org/r/20250101082306.10404-1-richard.weiyang@gmail.com
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 Documentation/RCU/listRCU.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
index ed5c9d8c9afe..8df50fcd69fd 100644
--- a/Documentation/RCU/listRCU.rst
+++ b/Documentation/RCU/listRCU.rst
@@ -348,9 +348,10 @@ to accomplish this would be to add a ``deleted`` flag and a ``lock`` spinlock to
 					rcu_read_unlock();
 					return AUDIT_BUILD_CONTEXT;
 				}
-				rcu_read_unlock();
 				if (state == AUDIT_STATE_RECORD)
 					*key = kstrdup(e->rule.filterkey, GFP_ATOMIC);
+				spin_unlock(&e->lock);
+				rcu_read_unlock();
 				return state;
 			}
 		}
-- 
