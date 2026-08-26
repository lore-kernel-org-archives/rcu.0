Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8C53B8D4A
	for <rcu@vger.kernel.org>; Wed, 26 Aug 2026 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787738317; cv=none; b=B6xSUCxJVRHt8ma2yEbWfcW5s8x48ui67g9bX1Wh16/xcjGR2NoyoZpoJUcNZyGz+QDkpT+1cllWYt8rgQFvSrBMK7VBioORYUA3Gt3aHFMOxF1k05iBAHKroArD9QxY1tNum0S7rg8xLVoi1m9uJNe3qi2YH01EcH27t/ClAnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787738317; c=relaxed/simple;
	bh=RDnnCTdjJ6akWeemPqQ3ZjxvzIlCkvD5LwMgsR6vkC4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JuC+WnKMhO3bg1q53yUfGTDuzY/284rRykgHXCSgGQJWit4iZIGr7nep3uAl2QsgpZDH6jDvFUwl3Q7RKO80+/FPnL1psTE+yfrrfwa+fFCI8/bHWBAkcFp98dCYy2XaCdvSXilpv2vCkm3RgD7gO+EUQ9bxW2lvDLPFkbp/fHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0uehXIT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0uehXIT"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so5828355e9.1
        for <rcu@vger.kernel.org>; Wed, 26 Aug 2026 02:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787738314; x=1788343114; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UBtoL8qC21Pn7cp31qTduZAok2vQhnrW+dfZVknNCzg=;
        b=a0uehXITs8eDNL1PzKanYyQIOLfoFriQMhNZ09HukUqYGH8xeQdYsowdkzxPVO1Z5R
         5hbEx66RkdaQV/48qGkwlvOWqSDy3io1kklMiRyjn1scFqUAshd86OonWNkKXv/4cWvJ
         KSI8P+5xa33P58Ant7RZNieOnOpUpYOB7jSwZ7BGrxlogBbN8PV+tYdxb00i2VKpRfDc
         d5nOQVc7Ixlh/yOnwO2+zHyBCG1OM0lAOzcCdmTnNX30S11l0taVvKKXmu0S6qjnAKeU
         V1stdRwnim2AG5ydsrIjQlgZIn0uHP5FmPvJue7G+cfH6dicM5CwnXfsT6sMn3qDujVB
         GRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787738314; x=1788343114;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UBtoL8qC21Pn7cp31qTduZAok2vQhnrW+dfZVknNCzg=;
        b=tFj3WV5f7r6ZygGO+ztwWJVGao90BwTDiSHojOn3QZNtCUKdtE7mxmclLvnIqbA71G
         TB8sRDJUj13tOJh2JAefqRVpEjSiVdqY74bloTvDFnZsEvbKuRF7rc7F3F9b6lbMrxh2
         +A5yz05yDcmrHX/NQue2Jp29yDJ37x08zLr5l36PjAWGdSooEoq3LdriOPAUvw3kbBgs
         2nr5t9+yXBJqH3BJr0hrvzzntUHCz10Y7EdcZdmsW5kIGeHeiLEVR+M5RWHeFfZPBfXE
         xT3Ig0k3scjYxgbmro1xylJ9n/cgiaSiPpQoEhP0dbgXzAEAU7iZ1j0H83xk/x9lz1wm
         5yKA==
X-Forwarded-Encrypted: i=1; AHgh+Rr9NayAhRLng7Olqz6MQWVg8/44p4ARQd4aU6g2c3tz4iogt5vjOlTYgZLhLQx53rm34mE=@vger.kernel.org
X-Gm-Message-State: AFuF++mO/rausHNzAfADbJvvCaDGrvYj/QzCsCbMtsgVwiVX3rUkH8Fs
	mT91qO7Q7EbHg4W46zCWr8QvHgP14eXP8GglUFQVs0ihl0qzCVjT7hfN
X-Gm-Gg: AR+sD12e1u236HioZ43wbZeMDZb2ULWIwbfIl+36YkxY+xBwTmKx6ZuZP3MT+zAUEEg
	Xm2/jvbZ7No8LoDdozMZKe0iBne4QWY5GsRT7FDiyGVYyVh3AFkDCivZPsRZ+y8kNkTB7DLIyuL
	wd7Xa1YYti1g8H3dgRqbe+IenhhtY0Xsljuz6OVY6/GV5/PTAQQ25yLl85i+kaC+xS7d2g/PNpe
	BoaDrOe3avKKasWzuKVkRheRoKrlK//ix3IezznHALK0zPNtNetpi16Ot0nLDYmsPB9Ep+nPmjI
	haC/lfhmQJ+JFljQxHA9BKdgF9whi5ukKU1flha7mKOm6vfZDaUixtn6SzOfDl00eMFYfY0VJER
	Nh9UQTiXYEwCWW+RL96kimtmlFKGb1xW1hkbIAHsovzHayS8AvXTUh62x0N1Yqp8Q3dw9Q6PEFb
	VFBKg8PSKNZXjg0Y96aUeD4PpbYL4hJSs5FQH66Ss3F9pYkvHzjPg6ZhSuM2sSX2LQJW39yHkNQ
	Aid67Hj19rLxbYUpcQQB2ZnDw==
X-Received: by 2002:a05:600c:c48f:b0:499:dbc0:370d with SMTP id 5b1f17b1804b1-499dc6eaca4mr38562695e9.2.1787738314066;
        Wed, 26 Aug 2026 02:58:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dd5721a0sm13428015e9.4.2026.08.26.02.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 02:58:33 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:58:32 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Dave Hansen <dave.hansen@intel.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
 <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Dan Carpenter
 <error27@gmail.com>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/uaccess: Fix casting in put_user
Message-ID: <20260826105832.7f1a6cc5@pumpkin>
In-Reply-To: <CANiDSCtP3krujoBo0Ai2xSrA5gkgmG5vNQuNXBDX5kK-kbRA7w@mail.gmail.com>
References: <20260825-unqual-v1-0-7024fb81b4f9@chromium.org>
	<20260825-unqual-v1-2-7024fb81b4f9@chromium.org>
	<2a772433-b0b7-44ff-a655-f8c26ee54d0e@intel.com>
	<CANiDSCtP3krujoBo0Ai2xSrA5gkgmG5vNQuNXBDX5kK-kbRA7w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Aug 2026 23:15:02 +0200
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Hi Dave
> 
> On Tue, 25 Aug 2026 at 23:06, Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 8/25/26 13:02, Ricardo Ribalda wrote:  
> > > Recent versions of smatch preserved the address space qualifiers with
> > > typeof()[1].
> > >
> > > This fix has discovered an invalid casting in put_user.
> > >
> > > This patch fixes tens of smatch errors like the following:
> > > drivers/media/usb/uvc/uvc_v4l2.c:1112:13: warning: incorrect type in argument 2 (different address spaces)
> > > drivers/media/usb/uvc/uvc_v4l2.c:1112:13:    expected void const *from
> > > drivers/media/usb/uvc/uvc_v4l2.c:1112:13:    got unsigned int __user *  
> >
> > Could we beef up the changelog here a bit, please?
> >
> > What _is_ the invalid casting?
> >
> > What is the fix?
> >
> > Why does it work?  
> 
> Something like this would be better? I will send a v2 if there are no
> more comments.
> 
> 
> Recent versions of smatch preserved the address space qualifiers with
> typeof()[1].
> 
> This fix has discovered an invalid casting in put_user.
> 
> put_user is using a casting with __typeof__(*(ptr)), which keeps the
> qualifiers (__user), instead it should use the macro TYPEOF_UNQUAL()
> that will use __typeof_unqual__ where the compiler supports it.
> __typeof_unqual__ copies the type but not the qualifiers.

This is a spares 'bug'.
You need to fix it without changing normal compiles.

There are enough put_user() calls that is will slow down compiles.

David

> 
> 
> This patch fixes tens of smatch errors like the following:
> drivers/media/usb/uvc/uvc_v4l2.c:1112:13: warning: incorrect type in
> argument 2 (different address spaces)
> drivers/media/usb/uvc/uvc_v4l2.c:1112:13:    expected void const *from
> drivers/media/usb/uvc/uvc_v4l2.c:1112:13:    got unsigned int __user *
> 
> [1] https://github.com/error27/smatch/commit/e53027a4e816a772403baafa83c09e4a94c1cb8f
> 
> 

