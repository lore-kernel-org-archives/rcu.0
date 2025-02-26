Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1619F225785;
	Wed, 26 Feb 2025 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584416; cv=none; b=n1aJHcCL3uvBXoXjPQHgIzsfSTJYpgLmjxiRaAm9fw0/N+1O3L4FH/vOhb8ZvA7bJq9mJHprXN4Thz0ixeMMiV+YYRpWjR064SioG0Pq3kpW+QjR7ScS6pgrd6wFt6Kd1m2HUAofdFtf9U96KyXAuLFA0bXKYj6/o78V520+Z1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584416; c=relaxed/simple;
	bh=LX9lKHB7J/Sp926ST10IdRatbigu0UA7eelyCUQ8uug=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pA/0sM5knNVI1uWWjslFsd48GWI3MnkZ6IBrs8Duf24ScgsisdkHJG79QsY6KOI64uo7XpFf9QDCb04IHzs348vBirtUjWeIx7q7/TlCU7U/esvlXDfOv0UkiwtBCX+GA59WDHvsIVHbPzSEaNFFjiO1bjnw1UqRNOKFdGxJalM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3c0McrJ; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3c0McrJ"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30797730cbdso68622541fa.3;
        Wed, 26 Feb 2025 07:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740584412; x=1741189212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O7L2Hmq1Tugg72Rbml2F5bkVZSahtOM1a0b2g+ur13E=;
        b=D3c0McrJ8tdxVviHMD21SA6Bbv1/S35jHGrns0gDQJjTR+JQIndZSt4nbtsc51AlS+
         +lz85QUmLLIiZAwt7Qi0dUYZ7IcpnGgyHgHJjQBy5EDfEdCeU2vXH5k+nhsw/jGL+kld
         1+lWm5uC/Xtd9SCRO4NNdesX5t9JbecJmlELDQKP7Sc0Wgt7/DFrIjLq3QQpWsJ3yUe/
         J7RzeoqlsS7rwqlCUeuP94oM2NRn3/GrrxFUYvUJGmQTHPDNpHo9w8aKwFp7EhZhMAQh
         j07D6kV82II5eGBXPGpYVnbONmO6958+wfmJpj3sLpbCBLgugm3xfi+HR+OBuGkGcHac
         HLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740584412; x=1741189212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7L2Hmq1Tugg72Rbml2F5bkVZSahtOM1a0b2g+ur13E=;
        b=hUrskRbzgmYJq2FdRVYMzVyvbTYZ9kbcwFNdjRn5MvCh/CETEAJOb46lXJGISJ7XSB
         QDMC2ncqAIlYAE/Gd4BOCNlzbzyyxZjJdNhJAkxb/BlN/6c5iCQzfoqv6o9k+6XaaFgz
         2NuX0aDiFrPFSXKsR1iZHOHPixEbxVyHo33HUyTC/jUpII0p5EXM2/lcZu82560r8Frh
         c1+FVtPOhsNyZBEwBfWxhdSwDLwt0+AUKW2raEbOg6PTGWNJrFBCjl7aEomczp5a0pW/
         ChDflt3M35UafU7uhoEC4Mrp75fRJRUiJmCuEBsO2lQO5qLzDiBut7HNDrFWdJJbHKX3
         wr2w==
X-Forwarded-Encrypted: i=1; AJvYcCWFe2ZgZrIIu23/RQFN7eAIYSKkbjJH1JZ6vX2M3r0Qd1E8Xxw4JQiHlCmIOyIu29785kir@vger.kernel.org, AJvYcCXNhrC+pziIMfvmK/Fhh9q2+PjCb9mfwXebShxO7fcTSLnkpC/VcNP5qVE7KVfAgQ0OFG8KstBm+v3LBic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDbc/1gTbeOD8Wuwxxz0VBRNpaUpOQe7Lw9enwD6Zi4IdQgv0i
	WVXYVKuqYVJAXyOBNCNlYjMgef8r82+7kbSx2RBhBeW/201XzQdF
X-Gm-Gg: ASbGncufURrm8rTKbntRdAytXLMQIcPXrAyiCsMAxNb+u57mN2EArm79r1STkDPW8qf
	Plnh2hBr0zwEiL/wyKxPs3TGRQJM9CT8YoGi/XxxV/bm8dm00zIyakaejwS9Vw4ft3eK/Wjk+I1
	bnRYvOg3Iju3MYvJiF4aDBe68SQHzVaT4dOoQ8hCDhH0WEyfX4KIdqR/ClfYB65zZed53xm0b6v
	zPbiVncZUwOYmFVIaz2bajrf07Sjtjpf6SBhI2Q/hfbQRAzzbQxDSpKim/+NtcSPh1itD3kJ66d
	Xg71sdjzNZtfMB0JN/nojTmKkh4M4bWwq4vC6qoB/CuGZoCT
X-Google-Smtp-Source: AGHT+IHS1X4U58RB24oH4u/yF0C7d4oRT5Mi+KpmI1mp2l/WxPYNeE8Z6PN4paH4DQMm0Q2Vzq7wlg==
X-Received: by 2002:a2e:9bd2:0:b0:308:f4cc:952e with SMTP id 38308e7fff4ca-30b79163e4dmr28141091fa.11.1740584411525;
        Wed, 26 Feb 2025 07:40:11 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819e0a37sm5504051fa.11.2025.02.26.07.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:40:10 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 26 Feb 2025 16:40:08 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 1/3] rcutorture: Allow a negative value for
 nfakewriters
Message-ID: <Z7812CnMT0-NLA4m@pc636>
References: <20250225110020.59221-1-urezki@gmail.com>
 <20250225212409.GA1807836@joelnvbox>
 <Z78lNRKjLQKigyLw@pc636>
 <186b2fd7-587d-4647-bbbf-7f6940de30b4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <186b2fd7-587d-4647-bbbf-7f6940de30b4@paulmck-laptop>

On Wed, Feb 26, 2025 at 06:50:02AM -0800, Paul E. McKenney wrote:
> On Wed, Feb 26, 2025 at 03:29:09PM +0100, Uladzislau Rezki wrote:
> > On Tue, Feb 25, 2025 at 04:24:09PM -0500, Joel Fernandes wrote:
> > > On Tue, Feb 25, 2025 at 12:00:18PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > Currently "nfakewriters" parameter can be set to any value but
> > > > there is no possibility to adjust it automatically based on how
> > > > many CPUs a system has where a test is run on.
> > > > 
> > > > To address this, if the "nfakewriters" is set to negative it will
> > > > be adjusted to num_online_cpus() during torture initialization.
> > > > 
> > > > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > ---
> > > >  kernel/rcu/rcutorture.c | 22 ++++++++++++++++------
> > > >  1 file changed, 16 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > > index d98b3bd6d91f..f376262532ce 100644
> > > > --- a/kernel/rcu/rcutorture.c
> > > > +++ b/kernel/rcu/rcutorture.c
> > > > @@ -148,6 +148,7 @@ MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu, srcu, ...)");
> > > 
> > > IMO, this should also be updated to reflect the possibily to set it negative
> > > and hence to number CPUs:
> > > 
> > > torture_param(int, nfakewriters, 4, "Number of RCU fake writer threads");
> > > 
> > You can set it to a negative as well as to number of CPUs or any other
> > number.
> 
> Joel does have a good point, though.  Could I interest one of you in
> updating the Documentation/admin-guide/kernel-parameters.txt entry for
> rcutorture.nfakewriters?  The rcutorture.nreaders entry is a decent guide.
> 
OK. Then i misunderstood Joel. It was about updating a documentation
about this!

Good point :)

--
Uladzislau Rezki
