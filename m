Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542A11BC59
	for <rcu@vger.kernel.org>; Mon, 27 May 2024 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716839205; cv=none; b=RGNPe9Oz65JsjxrJxKUFlSvaWnhi287ufoCZ8O3QxSPFrEAi8DpYwQxowGbU7pxr3T+w6tuAu2U6WVsMGbAOBWHykQgexJnSCKlEikyO+3Z6IWvLJeB2x72Cb2dyjww0fmMnPzku26i2b4c4AV8a+c7RSqX/tYDqseHGbR1DMhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716839205; c=relaxed/simple;
	bh=7wn1OBXeu+8dWR0fPCJ8V7wgRoOzWgoEltNlr/om/Ek=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnsjFr46oPn7ep4OOAipwIyXe4Io5HC3Gf1ugsAUO1Y2o6y2MVR6SjPOU84TU7zS8snXc4FRg3WwIDxOn1bJLxcBO9F4snLZ7XDgH6DdiGxYUI5pfIrJOgakHtwnwy52oblAs+KgeTbo0YrzqOH0RT3T/aRHok/rj+9AFVRtXJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzEa9M+x; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzEa9M+x"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-529661f2552so121806e87.2
        for <rcu@vger.kernel.org>; Mon, 27 May 2024 12:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716839202; x=1717444002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uk4/aJQTAd5pz4e6cqiB7ALvx+m5tyRF7o2u1p+ZhPQ=;
        b=OzEa9M+xsD0fbDtB03ou95e2nTpT268ErA6yysjeIEm7pF2wgu6MQU5NVn/lMxBK04
         cPnYuMCecT0trIKVhSiy5zV/thd2c4XKzFfbxUrnjV8TkN+w2N76p9ONryXsIMUTLex/
         qaPvmSxDuaarfEmwjKUsqDu8SgJmNbzIdTZ/cqdluhJyiHjFy1dft+Tu8vX6d/O1YBFL
         Cq+A5Nn/z4hZ5bfVjcjKx0w2V248tZrvCOEKmn9Ve+IjooojGV36S7kCBACyG2ky95D1
         09otooPyegsEImKNS2n+BffH9ldCG4OlA29GSBM8KTjKnIPFfu/7f/AZtaVJZfk2v8H3
         gglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716839202; x=1717444002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uk4/aJQTAd5pz4e6cqiB7ALvx+m5tyRF7o2u1p+ZhPQ=;
        b=ehxreG8ubrNVOQ60qRPVaLnfjMCNZC3VA/2MNfN4mCIj7h0cbkKAxQFlc+EF6vW45X
         UvOnWpGyHcFoqV6HeM+6qQrk2ZveqXKWqF0EuQTz48AO1As4H6NigHrT2/ElVogAXc1d
         SVqt6b6PKDtI1Xng4+SK9IRPcrqUF7pF6qDRL1bNGEwBBSc1cDtxf5G3086jBFZjzVCX
         FVFbizLwYwaRfpHVsgQv3kjhoB+xGPcxL7xeJWQmHDDQ9Dv3U0bRugGLSZI1mmjJ4fHY
         /NDc6hTpCA9x8LeXMFQEYrOTIfDKgKhwdMKAzFiGYvMp4yZO17yIZnv1lZTzZTfLaMZv
         ho/A==
X-Forwarded-Encrypted: i=1; AJvYcCXpsnxmivvNpIJRQ1wIB9xJjWIjFNjNzMQ8P5SQmVN398tOkSlt7zbsZtcibYk/FxQh3aSWfUY76vSYzJG4hLAjsVYi
X-Gm-Message-State: AOJu0YwxJVthrKnakjh+vDBxl1dIWm1Nq0UO9HlD6SFWzr5w3BM85GQl
	NZyF2isHlyY6sX4jxzLKjkezHNo94rEo+VKgRBOu4NSZKdNyjrv3
X-Google-Smtp-Source: AGHT+IHCl6MY0a8pMw8jeqgnIPKO0XHXb2qaV39jOueMYwz8iYj7Af5QyL0+IIxWYZ6N/sXg2T3Thg==
X-Received: by 2002:ac2:4acb:0:b0:51c:43de:b18c with SMTP id 2adb3069b0e04-52964eaf6e7mr6245099e87.27.1716839202093;
        Mon, 27 May 2024 12:46:42 -0700 (PDT)
Received: from pc636 (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066b0a0sm736285e87.177.2024.05.27.12.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 12:46:41 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 27 May 2024 21:46:40 +0200
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Julia Lawall <julia.lawall@inria.fr>, Vlastimil Babka <vbabka@suse.cz>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	RCU <rcu@vger.kernel.org>, cocci@inria.fr
Subject: Re: [cocci] patch idea: convert trivial call_rcu users to kfree_rcu
Message-ID: <ZlTjIDrnPb25UTUn@pc636>
References: <68b85796-c674-4691-936a-2051849f4692@suse.cz>
 <6b7e3ed9-d974-cb3b-6839-a6b7cf5f5a36@inria.fr>
 <a1f15e67-25f5-4a0b-a9d0-ebbc0555fb12@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1f15e67-25f5-4a0b-a9d0-ebbc0555fb12@paulmck-laptop>

On Mon, May 27, 2024 at 12:27:14PM -0700, Paul E. McKenney wrote:
> On Mon, May 27, 2024 at 10:13:40AM +0200, Julia Lawall wrote:
> > 
> > 
> > On Mon, 27 May 2024, Vlastimil Babka wrote:
> > 
> > > Hi,
> > >
> > > one bit from LSF/MM discussions is that there might be call_rcu users with a
> > > callback that only does a kmem_cache_free() to a specific cache. Since SLOB
> > > was removed, it's always ok to use kfree() and thus also kfree_rcu() on
> > > allocations from kmem_cache_alloc() in addition to kmalloc(). Thus, such
> > > call_rcu() users might be simplified to kfree_rcu(). I found some cases
> > > semi-manually, but I'd expect coccinelle could help here so if anyone wants
> > > to take this task, feel free to.
> > 
> > Thanks for the suggestion!  I will try to look into it.
> 
> Thank you both!
> 
I wanted to take an action on it but Julia was first. So, please go ahead :)

--
Uladzislau Rezki
