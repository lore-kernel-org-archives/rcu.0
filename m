Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B13612B89
	for <rcu@vger.kernel.org>; Mon, 12 Feb 2024 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731071; cv=none; b=jlShL5qU1Rfhn9Sv47m343xFF6Z+8tPJSYXhDNI0C+qK5l3ELyNAuLuwPVxaxr0nb+/u7qAi5vZd5G1NeIEJjdi0l1HjNIG9KWJQmmbmfmRlVJ4CSWZGDCGSwlFU0FU2OSzl4/a3D0s2PLeaEuVQOFXenwisqFuxPF7ptECbVEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731071; c=relaxed/simple;
	bh=Mx6kONABD9j93lpHhl+NEV7+QJSDS6YeZUbXI8k9VDY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jfx1q82jRiSEzob0iSvW+fFlUoai19aRKwjRegD5i+i78kUjENZBh0JTKLYJEQJKjhbF/+zeV3GR/5e0P+mWwcJi2QVzGP9fuMwN4lAX25hrG0kkqvPioCp08zf5DlJYbWgNK/XwbR0IcDlkVXNbLbF1qtufbQDxW1d8JWnkLww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EW1OT1Lp; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EW1OT1Lp"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5116ec49081so3169696e87.2
        for <rcu@vger.kernel.org>; Mon, 12 Feb 2024 01:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707731068; x=1708335868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sk9VxfyoBmdKu28L4io4xZ05C/H6LRkjLCRmZAR7hsQ=;
        b=EW1OT1LpHyt8eanmFCs4qon/YSEsiS0y8Tl4TOVP8vViTdVMOJ5doXUiOVAyjHEQxN
         gOmg/NcXoM2DXSw86Y1ldiN2qtHJ7GjrqLOtBqeLTr1SPKDVRVmy31VHkuCWo4VVFNpx
         vF9ZqN1xPMUMziNPTEgYTBH6E597RcI/HqMUDaIZlm6OOGJmdjEdQjAk2AdNfYVELLQn
         nS2OObtczfTYwXRIhPjxcOokq1iPniolOZzLmzoT0x2X1NApifSNcsolaiS6dBi/rjFj
         cAOnoEeOolG9mFrfHDHyzXGBCb7IBmzRP0V9tEqchNetjSK4XGzwwNLhPCrHciALHSGp
         1zXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707731068; x=1708335868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sk9VxfyoBmdKu28L4io4xZ05C/H6LRkjLCRmZAR7hsQ=;
        b=kQYRf9wRgd8QhsE3QBoea9iK1ENZeG5nizgjsB//Z92Cszidw5U75s7fGGExpzWwhv
         O15zuSWrVVLCDeBrtYA9GZFAKiobqHrZ5w2A0jKMXGJCp3xi6cP+Xf5pfwzuASo12v8v
         jQWwrDZGC3gz6pueFEPSdHTK0fM0QUG2B1PdkDO2WplvwIcbF9nUsgpvKCZtH1XGUE0G
         baZlwdimZDQopy3o1iKkbGEcXZ5KNQm1ilRRhupyTiUvligDvuN6aMch7GaS4l8bkXW8
         b8j1obxqMS5/1IcZaIxL17bpb7kiNZ1IGUIqfFMAR4imqY2WzLXibsLiOidJid+GWRrF
         AOvA==
X-Forwarded-Encrypted: i=1; AJvYcCVGfTuNrki7bX3tKx86oRHP+r1XYtYEjbZ4s7CW2rmqzZAzyP8Dt+oIGQrlqKN1yThN7FkTphSkq1rWc7vHM0mqB4Je
X-Gm-Message-State: AOJu0Yy9d6YPS0K8ynWlnrZHwFdsufdUesblBePk7qGNaeWVdMXQxz7l
	iTuHeIwA/7OOTef04x8QbNiLy8I4IpPsbFCwUpnxHFmiDAtrj9cv
X-Google-Smtp-Source: AGHT+IELP93Umvc/TQj3J7KUgMiguMddRF16BRoKCYISNKz4B5xstNnCEtGOkerEUFL5G2YiYSjh6w==
X-Received: by 2002:ac2:4c8b:0:b0:511:60ba:a02e with SMTP id d11-20020ac24c8b000000b0051160baa02emr4180562lfl.40.1707731067943;
        Mon, 12 Feb 2024 01:44:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWF+l23yChfzZhOYWZLAS8Yek3OfBoehBdZ9vrioYKPo3kLE8ym0fQobhzlJ+0cocGxknwQTxQfyn2ZB1nbOHaSP0SG67lvZ1Iy57iy1vb3ZWVlJAWp6yB6xAah2IGnW0KTSxHswniOm1bz/vyrBO8WP0t2/lHh83t9uexLvLx1Xc/LZq3zgRfw6T3KMhM/m68ijEXIvvasqryw
Received: from pc636 (host-90-235-18-79.mobileonline.telia.com. [90.235.18.79])
        by smtp.gmail.com with ESMTPSA id j17-20020ac253b1000000b00511696f0d95sm804768lfh.203.2024.02.12.01.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 01:44:27 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 12 Feb 2024 10:44:25 +0100
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrea Righi <andrea.righi@canonical.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org,
	"Cc: Frederic Weisbecker" <fweisbec@gmail.com>
Subject: Re: Observation on NOHZ_FULL
Message-ID: <Zcnoed4JqpRmdb7M@pc636>
References: <ZcJxhoNpkTM7LnOr@gpd>
 <9f9b6885-6d9d-4f30-9635-49443e1615e9@joelfernandes.org>
 <ZcOwRsEhbQhGv9X2@gpd>
 <CAEXW_YQN=Dm4TXv+F=Q4bfnKWn1Tv52=8hz50JLkbufcM5hUpQ@mail.gmail.com>
 <ZcO4c6nxemyxRFz3@gpd>
 <1fcf7e8a-c245-4c5c-ac86-7f0a1531032d@joelfernandes.org>
 <ZcR66cxax008lPGv@gpd>
 <ZcTO5lKeZoJZH1Mp@pc636>
 <ZcTqWiCJXg4H1wxp@pc636>
 <29e6c22d-0487-42a5-b840-e3c7ea7c6270@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29e6c22d-0487-42a5-b840-e3c7ea7c6270@joelfernandes.org>

> >>
> >> I have done some basic research about hrtimer_interrupt() latency on my
> >> HW with latest Linux kernel. I have compared below cases:
> >>
> >> case a: 1000HZ + lazy + nocb_all_cpus
> >> case b: 1000HZ + nocb_all_cpus
> >>
> >> I used "ftrace" to measure time(in microseconds). Steps:
> >>
> >> echo 0 > tracing_on
> >> echo function_graph > current_tracer
> >> echo funcgraph-proc > trace_options
> >> echo funcgraph-abstime > trace_options
> >> echo hrtimer_interrupt > set_ftrace_filter
> >>
> >> fio --rw=write --bs=1M --size=1G --numjobs=8 --name=worker --time_based --runtime=50&
> >>
> >> echo 1 > tracing_on; sleep 10; echo 0 > tracing_on
> >>
> >> data is based on 10 seconds collection:
> >>
> >> <case a>
> >>      6  2102 ############################################################
> >>      8  2079 ############################################################
> >>     10  1464 ##########################################
> >>      7   897 ##########################
> 
> So first column is microseconds and second one is count?
> 
Right!

> >>      9   625 ##################
> >>     12   490 ##############
> >>     13   479 ##############
> >>     11   289 #########
> >>      5   249 ########
> >>     14   124 ####
> >>     15    72 ###
> >>     16    41 ##
> >>     17    24 #
> >>      4    22 #
> >>     18    12 #
> >>     22     2 #
> >>     19     1 #
> >> <case a>
> >>
> >> <case b>
> >>      9  1658 ############################################################
> >>     13  1308 ################################################
> >>     12  1224 #############################################
> 
> Assuming that, it does seem the "best" case is off by 3 microseconds (9 vs 6),
> still would not warrant being regarded a bug and possibly just in the noise.
> 
I also think it is a noise.

