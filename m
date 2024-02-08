Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994E7763E3
	for <rcu@vger.kernel.org>; Thu,  8 Feb 2024 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707396845; cv=none; b=j2lQL8etEcy9np2F+ISN7HUMbHKe+u4UQIpG0TSi1GRUiC1ZDpsDI/xjiVFK/8ujfiQHbE29K81XUfCzMQu5lbTnSzuwsWFbifaT8g2VsI+7lNIs8HegcDt1pqN1ejemXYBpKONNY368TPez+9hrvdRu9IF0/LQ65kXZmFvr8p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707396845; c=relaxed/simple;
	bh=dOhZvUFls5sW1KEQAjppBsPiSJRFZHIAQemSYQmJcpE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggI8YLQ0R17I+/34R9LFoDDILL9OQndc9AmCCWjDzvXVNsCKw4jRsykecgC9JcywBpyhx8616Bhc4mMfmIipR9rMIgw6RqN6kfxS0SOpcCR6VP2xOcmSYCHoJ5wvpbIJ5FhCSX/RN5UZtCmJj2KtTNNlsIWkX/KY+JePMGAlbLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnRNY0SY; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnRNY0SY"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5116588189aso3049413e87.1
        for <rcu@vger.kernel.org>; Thu, 08 Feb 2024 04:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707396842; x=1708001642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BuJm7OL725MF5CHz6DcEsZIWMCYz4TbndfJeiB658IM=;
        b=bnRNY0SY71A9ikzmZFOncGIFRBcl08a2Es3lDJDiP7/Slfur5/h98ZWY4p1k4Re4F/
         uFrWzZzLq1wBfwfpP5G1TJuoZ1LY3OLy1UkbAWs5lcIRApE6os8WWqpzWfvu3KrkTsHE
         DO2L0igorZL21jL5AQjHPXeG+9u30PCJr8N4uVNY5OFFT08dQwIn3YzLo3KKslBOE60g
         8DVNl0RT4Gtf/B8i6hyFfu2YZ+wDn3fzDU8BmwesWseyCJBbfsSTfG639tPcqU+YlHm+
         PA6JvaCb4MWTYxf2A+S4dEFZ9khGVQI5FC8C2vioqT3myLnSWQlfd9xZwp6NjuqYrc4O
         MQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707396842; x=1708001642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuJm7OL725MF5CHz6DcEsZIWMCYz4TbndfJeiB658IM=;
        b=dBlh5jcS+xr8JhVjsmCpx1ogsQDiFzHI26oyjWrRl1ZTEOQOYoBXkXySiiPE4Vbi1u
         G6lEEzesodj0Rw4rcMKCS2wn3n13kszZje6XGLf9vDp2Kzf1+oUAx4xZ7JcUKbITv1kB
         VTPaP6BJbsCQY7QXkrw3T0QUn5wE9OZjPkNL29QsTQMKlmK9qvHg0/9Y7//Z0F7zPaO+
         ZnNhjfFYdwNiDZUQTJAUwV0clBI2bcbjSyIJF8I8hsYhltJqRViH8tgkB1QA42v3g1sD
         V2Zg58fKSGM7AqYZ5ujDTRsNnb8FIILRbiz46HI0nLHN5KS2UF0LKK1/RVBvvDP7JR7j
         q7qg==
X-Gm-Message-State: AOJu0Yz2pOnPaGtNr1zPs37OAoyKOiu3+KeAR28XYdd7mGhMLT95imfs
	IpWAu2P08kiVmoztZprvQSLPFrYc3FgI1ceo4KVWmfJlrrLuwbyMfoy3MwAq
X-Google-Smtp-Source: AGHT+IFCtv2qJfmWksl1ZBWeV/JzrNB4haWANo18YiqzK3iYIzEPFlOyiVCUXnmHksmkXmD2ymbptQ==
X-Received: by 2002:a05:6512:128a:b0:511:47ed:d744 with SMTP id u10-20020a056512128a00b0051147edd744mr7417549lfs.12.1707396841353;
        Thu, 08 Feb 2024 04:54:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCULmNihfJkQr21CkfJxcW+cVcailJxPk3cCHrbcTU60qiodQzIsHKMyaCrfYkoYtlg0Ie12EgTDezL8QJBQIrTCL9Jls45vbyfQ6BPVTeo8VR72s6YP2Sq1HUAO0lKanKwdVvR6j3LxQQY5kqkKoGYuqymaBso8v2yH5ljGG5pLPFlJWunq+y1qlwrWPvVhH00=
Received: from pc636 (host-90-233-221-0.mobileonline.telia.com. [90.233.221.0])
        by smtp.gmail.com with ESMTPSA id s20-20020a197714000000b005117213285fsm69163lfc.117.2024.02.08.04.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 04:54:00 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 8 Feb 2024 13:53:58 +0100
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org,
	"Cc: Frederic Weisbecker" <fweisbec@gmail.com>
Subject: Re: Observation on NOHZ_FULL
Message-ID: <ZcTO5lKeZoJZH1Mp@pc636>
References: <ZbjYSXhIrVyCpRNM@pc636>
 <ZbjdL04k2Z2ZdUyp@gpd>
 <b8d80604-18a5-4f82-b846-5c00c6aeae6f@paulmck-laptop>
 <ZcJxhoNpkTM7LnOr@gpd>
 <9f9b6885-6d9d-4f30-9635-49443e1615e9@joelfernandes.org>
 <ZcOwRsEhbQhGv9X2@gpd>
 <CAEXW_YQN=Dm4TXv+F=Q4bfnKWn1Tv52=8hz50JLkbufcM5hUpQ@mail.gmail.com>
 <ZcO4c6nxemyxRFz3@gpd>
 <1fcf7e8a-c245-4c5c-ac86-7f0a1531032d@joelfernandes.org>
 <ZcR66cxax008lPGv@gpd>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcR66cxax008lPGv@gpd>

On Thu, Feb 08, 2024 at 07:55:37AM +0100, Andrea Righi wrote:
> On Thu, Feb 08, 2024 at 12:54:58AM -0500, Joel Fernandes wrote:
> ...
> > >> Slightly related, but one of the things we are wondering also is how
> > >> much of the overhead for your nohz-full and lazy-RCU test (on top of
> > >> baseline - that is just CONFIG_HZ=1000 without nohz-full or nocbs) is
> > >> because of just using NOCB. Uladsizlau mentioned he might run a test
> > >> for comparing along those lines as well.
> > > 
> > > Just to clarify, "lazy rcu on" results are just with rcu_nocb=all and
> > > lazy RCUs enabled (and HZ=1000), so without nohz_full.
> > > 
> > > If I enable only nohz_full=all (without rcu_nocb) I see something like
> > > this:
> > 
> > Ok. I did want to mention nohz_full implies rcu_nocb on the same CPUs as well.
> > 
> > Its also mentioned in the boot param docs on the last line of the description:
> > 
> >         nohz_full=      [KNL,BOOT,SMP,ISOL]
> >                         The argument is a cpu list, as described above.
> >                         In kernels built with CONFIG_NO_HZ_FULL=y, set
> >                         the specified list of CPUs whose tick will be stopped
> >                         whenever possible. The boot CPU will be forced outside
> >                         the range to maintain the timekeeping.  Any CPUs
> >                         in this list will have their RCU callbacks offloaded,
> >                         just as if they had also been called out in the
> >                         rcu_nocbs= boot parameter.
> 
> Ah I didn't realize that, it definitely makes sense, thanks for
> clarifying it.
> 
> Then basically in the results that I posted the difference is
> "nohz_full=all+rcu_nocb=all" vs "rcu_nocb=all+lazy_RCU=on".
> 
So, you say that a hrtimer_interrupt() handler takes more time in case
of lazy + nocb + rcu_nocb=all and for nohz_full + rcu_nocb=all it faster?
Could you please clarify this? I will try to measure from my side!

I have done some basic research about hrtimer_interrupt() latency on my
HW with latest Linux kernel. I have compared below cases:

case a: 1000HZ + lazy + nocb_all_cpus
case b: 1000HZ + nocb_all_cpus

I used "ftrace" to measure time(in microseconds). Steps:

echo 0 > tracing_on
echo function_graph > current_tracer
echo funcgraph-proc > trace_options
echo funcgraph-abstime > trace_options
echo hrtimer_interrupt > set_ftrace_filter

fio --rw=write --bs=1M --size=1G --numjobs=8 --name=worker --time_based --runtime=50&

echo 1 > tracing_on; sleep 10; echo 0 > tracing_on

data is based on 10 seconds collection:

<case a>
     6  2102 ############################################################
     8  2079 ############################################################
    10  1464 ##########################################
     7   897 ##########################
     9   625 ##################
    12   490 ##############
    13   479 ##############
    11   289 #########
     5   249 ########
    14   124 ####
    15    72 ###
    16    41 ##
    17    24 #
     4    22 #
    18    12 #
    22     2 #
    19     1 #
<case a>

<case b>
     9  1658 ############################################################
    13  1308 ################################################
    12  1224 #############################################
    10   972 ####################################
     8   703 ##########################
    14   595 ######################
    15   571 #####################
    11   525 ###################
    17   350 #############
    16   235 #########
     7   214 ########
     4    73 ###
     5    68 ###
     6    54 ##
    20     9 #
    18     9 #
    19     6 #
    33     1 #
     3     1 #
    28     1 #
    27     1 #
    25     1 #
    22     1 #
    21     1 #
<case b>

I do not see the difference, there is a nose of 1/2/3 microseconds diff.

Thank you!

--
Uladzislau Rezki
