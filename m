Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BF347F5D
	for <rcu@vger.kernel.org>; Tue, 11 Jun 2024 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126828; cv=none; b=im83JZ+g8LMl8f5rPZKse/TtkU/8A7i8l/IH/XlKmpXOCfGZSZnRwn2XZhmTG2DqkJ7q3eyciq18tiyECdqV9q6J1RztcFMgUD+QP0QiPE8Dxj8bh3/YNGI3SjBjJKcSiud3hbVvXYVmtgoQS8JHmRA5zz53mKmU2nE4knel/Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126828; c=relaxed/simple;
	bh=5z4p87CfIiea+uQllZ+kJlHPSQmWP96eJO1i1YiQIXQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oonl+8caySvaeRyzJyuYpherLoHWJkftbadNghO6IAFnqWok8R6qAM7NoFUm+Q6kK2lR/134cVRrjwvqa4L6NH52Hgh5P/7QImTEMWDAbe2pgmvtM2Gl1ZMQSSFJP8pn3+RPdDdv+nB+9SW5DXOMCyOVu7f9yk1WRL5UGSyhTZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWaNX+p3; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWaNX+p3"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52c84a21b8cso47160e87.1
        for <rcu@vger.kernel.org>; Tue, 11 Jun 2024 10:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718126825; x=1718731625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuNAT17Yia2ED/GBtljPyXNC+kaiVErMdlGJkLgW8Pk=;
        b=lWaNX+p3Oya5EcFB45iEua7lYdp1uDpZVnk93Jg6rbiFYGjpWT2FxFCQlRZNJTpbk2
         cCKqhHMsjz/gH2ZEE2T8FnpAQ/OImqljWX/A4j6eHwhdRPD6sgN7HZWjBtIcWV3YkRT5
         x9Y/XQq483inxO6gmOouKsTnpqDtXxVxW6NG7xhZYrXQX3jASbzydMrMQrJu071GqafC
         vYJe4ztnVLI27VKDfA0oNvX9hL0t/fx6RbCW0cNeCVVW48YHJKFjA3qgWiD/zNqanw47
         P6ScTN1woBtjuEUN7a0dKiz48QH+eonA7X1HdN8gYpCWomW+Gamr1UTzTjGfY+DLDwAe
         v8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718126825; x=1718731625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuNAT17Yia2ED/GBtljPyXNC+kaiVErMdlGJkLgW8Pk=;
        b=O7rkMEkv5nrHjbQNiWGHa/F88toa+H1lBTVDeslJbmRh4xTW9Ho5SZim1Kb01vHq7e
         7bELRYQ/ek6GgkwSQDJ2agWmBDzk0NY+lgglQ4CmRFsk0t5rBQm10MTEjs+Vt4223rnl
         DHw6Hihi/QEQbmAXxBpsU4hJ1Rtj4i1hrfc4ngy9Wl6dXc0LdlCZ7Z9VgJCqR0tsx5vv
         PhEqbp8lN/qcr9qeXG7ghIMTDHZHUsaC5ogDUb7XBG+5686Q4W5bInVcnlvoCcSg/ziR
         1zzir/4dqnYrtfdbeAvjwI0Pb6rHUFDmv1X+ZmyCj9H21ETbNcACBR4Hy2YojKLoKIe6
         jJiw==
X-Forwarded-Encrypted: i=1; AJvYcCVR4txFeNlkyy/4mJkDybx26DRW+3O2Iw0USTubnjMfa4VLIdZD358d3aJrEvo7DNGo+lEN3YkLugezFpa98yF7uJzq
X-Gm-Message-State: AOJu0Yw4bP2TvLjXPWSVH+KCZED0G8Q31eHvR1Ua3pcnFOSF/r2Ty4gY
	GhQjEeL1ezCL6aYCEFOJl725ZjV8hj4BYV3a+rtLtD5lnd0L8Sv6
X-Google-Smtp-Source: AGHT+IGGTOvlVJb8KnHeT+pJ4WbUN0we9oe9aXR38gJXbm4NnMBWL95m6/WpY1sx6qApjEeWgxI6HQ==
X-Received: by 2002:ac2:510c:0:b0:52c:884a:96c7 with SMTP id 2adb3069b0e04-52c92437759mr943923e87.17.1718126824740;
        Tue, 11 Jun 2024 10:27:04 -0700 (PDT)
Received: from pc636 (host-90-233-193-23.mobileonline.telia.com. [90.233.193.23])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c9108266csm503259e87.151.2024.06.11.10.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 10:27:04 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 11 Jun 2024 19:27:02 +0200
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>,
	Vlastimil Babka <vbabka@suse.cz>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	RCU <rcu@vger.kernel.org>, cocci@inria.fr
Subject: Re: [cocci] patch idea: convert trivial call_rcu users to kfree_rcu
Message-ID: <ZmiI5pE1PK1Tv1y2@pc636>
References: <ZlXIDZLMNPc7E7XE@pc636>
 <2dd5bafb-ceb1-238d-2f51-83ebf135b73@inria.fr>
 <ZlXaPuA4lC2ANTdN@pc636>
 <2ec7eb0f-0950-4d65-b33a-64df7c5f89c9@paulmck-laptop>
 <77531e55-3418-d4be-f538-7ddc904ed88f@inria.fr>
 <Zl76AZ_0H5xb1cFl@pc638.lan>
 <alpine.DEB.2.22.394.2406091158420.3474@hadrien>
 <21a32cbb-d388-4a8c-9298-ef8c82330f9e@paulmck-laptop>
 <Zmh-EYvXqL3JBt1p@pc638.lan>
 <c751813a-0ab7-4629-bdc4-00f472ae18ec@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c751813a-0ab7-4629-bdc4-00f472ae18ec@paulmck-laptop>

On Tue, Jun 11, 2024 at 10:25:52AM -0700, Paul E. McKenney wrote:
> On Tue, Jun 11, 2024 at 06:40:49PM +0200, Uladzislau Rezki wrote:
> > > > 
> > > > These look ok to me.  In the last two cases, the callback function is also
> > > > stored in a data structure, eg:
> > > > 
> > > > static struct mfc6_cache *ip6mr_cache_alloc(void)
> > > > {
> > > > 	struct mfc6_cache *c = kmem_cache_zalloc(mrt_cachep, GFP_KERNEL);
> > > > 	if (!c)
> > > > 		return NULL;
> > > > 	c->_c.mfc_un.res.last_assert = jiffies - MFC_ASSERT_THRESH - 1;
> > > > 	c->_c.mfc_un.res.minvif = MAXMIFS;
> > > > 	c->_c.free = ip6mr_cache_free_rcu;
> > > > 	refcount_set(&c->_c.mfc_un.res.refcount, 1);
> > > > 	return c;
> > > > }
> > > > 
> > > > Should that be left as it is?
> > > 
> > > Given that ->_c.free isn't used in the RCU callback, I am guessing that
> > > this is intended for debugging purposes, so that you can see from a crash
> > > dump how this will be freed.  But I could be completely off-base here.
> > > 
> > > One approach would be to remove the ->_c.free field and call attention
> > > to this in the patches' commit logs.
> > > 
> > > Another would be to instead put the address of the allocation function
> > > in ->_c.free, and again call attention to this in the commit logs.
> > > 
> > > Is there a better approach than these three?  ;-)
> > > 
> > IMO, "_c.free" should be removed:
> 
> Why not send the patch and see what the maintainers say?  If they object,
> you can always fall back to one of the other two methods, depending on
> the nature of their objection.
> 
I can send the patch :)

--
Uladzislau Rezki
