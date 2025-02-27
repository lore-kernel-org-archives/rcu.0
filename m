Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F4E1DEFEB;
	Thu, 27 Feb 2025 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678261; cv=none; b=EggTWUKiWIVviMHV7EKQpSmFyxxqAeydvc1pOWpOGTtk57FzifnPnhG0IYd3/w5QvoYhuMjGEUhJMvZaKO90Tzup+/5UIw44H453OvcUH6nEJWH2nLry8MLLMipGvs8wDYu0ixw+QHmHsFynjxCdF5Y6ghKpOOzAsyLh5GG7bmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678261; c=relaxed/simple;
	bh=jIDEnSIPQbFfExmTC460MWObe17Tb9qy5aFuBghQhYo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bisGVKNrikxzhklzxoxURLtVJ4dkud8X6wAdFXtvbCTz+1xKhASP6ALvv21qeHeE9u1Z+KpVwe2aVSmdU/ec7xGGMWqH2twEnpIsdBdp3NF0BEsZRFp5uhficLC96ndO+9FZ+VJyccJDbgQCwIYl2bv1/vQRZtJQARJaWI6/evk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWaGp2LU; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWaGp2LU"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5494bc4d796so196273e87.3;
        Thu, 27 Feb 2025 09:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740678258; x=1741283058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+kPjfRpGRka+XnOdnG4bcjCQPFB/UOhax6LyvKzL3iU=;
        b=XWaGp2LUescMOwdtdAhqCEc0OyEyJFLYIwOSgOcvuTtJlZoEHKwWVv6J6n4rttXdy+
         d1eYONJ49C+vAfuJorqhAKlCs9aAnx/9+hCJ/6cEDvLwfYdKNnTrPRDNarNW+7+gX9tR
         +LN+spQwxCL3gO9AazgAElvVjIWzW46+ZUMVOG4EOQA0E/KSyxo9JxEHZpa7jtqmA6Ot
         6KFUpcRAxZo3ygjvXPJWmtVz2slHN5FsiROMUmZgttUDXiCq6siGkCrLs6rQbDDGgL+o
         4poRkuHMTg2zhHl5GWiomr2r7GPGBmVQyvGoRZ4si7yzuSTEoy1p3TgB8hUGygkRpvu8
         WPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740678258; x=1741283058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kPjfRpGRka+XnOdnG4bcjCQPFB/UOhax6LyvKzL3iU=;
        b=l4v2Vky/iuslHE2Ym4maEnmuboNpQOJeBqYxWIuVv8HioOpNXZlT9g4DCuDmjzY+4v
         0229vMQDGZMiv46f6oJ8b+9TX42DWrMBHzJVekl4Hs4i31LmTJAgcu9aSCb2M8Fl8H3v
         CMl4kyzof5fnVLJTFmyVAf3j0rlX1WOwif1Y8glueTKjtpNvk2kBtFJXuCKAxBqMjWHS
         jM5Q2paKcB44MuvuGpmMdPc1cSJkmrj3bVvY4CpZw5c7RLNTgLVKXYo9YKYdISIp1yqA
         YZNFtTmzHQIq9FwO8PpIrkLBv8WCZHsvlmlHHuxq9wr8FeNPhnsCWpRmUuOjYT/CaXVv
         zHKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGEO3USXTgG+pREu67UfeMOKSuaMEsdru1DJfoDwtA/QT232rmRhSKkEAnE+zdcJz0Cni1@vger.kernel.org, AJvYcCXrdZ4J/3TVlO1NGt6NxMXYSBaoYkKh0dHC7kSmRpsg3WtLgBvLDqIZNdu47aKS8y4GFYXLDwHxZnaPWLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7b9+DBWvn8Aui6uppBL3Oogu3jyuWnVxnty2/4s8nqFjfenZk
	7O3uxui1zYsGI2gV241fEZh9CUfIonqg9s1vzQ3TDIKEiqzgeSkU
X-Gm-Gg: ASbGncvz9yIzzG9clmwfGxatg/zFDvftK2JZD7yTT6F8doa660qotG5XmaWBAvZekHK
	DWr9+SIBo5+SyWR/WAQJd9wuXsW3tLGMLzChBoz2/LtRjKJHxDBntFDNFScJ2FD2VS0B7VWy1cI
	keyYIfPxs2BSsT3Gs1BaWUxAcvuov/aM+r6xRdSBNS9eIlFPkgsNjgGPQMnp7SD/23dKW8/DNLa
	XaEmJ2Uw9ebt2/oXP6p311u3i6ETtkma/ZlRj4tiG56acjh8kHxE9jj8tFkP658z77DyU8hKLsY
	bTbVCWx05Nt95zCwxnfJQkeSvp17c2b5X6S00liNRuc0QA91
X-Google-Smtp-Source: AGHT+IHYKO2+7ab78Gcv+LzYpCAqHPLlvJNLrKf9EGC/h3+5JmkdHcq4c07Vdys5iwDgmutQTGKXzw==
X-Received: by 2002:a05:6512:104a:b0:549:4444:605e with SMTP id 2adb3069b0e04-5494c38d615mr149485e87.50.1740678257907;
        Thu, 27 Feb 2025 09:44:17 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494417424asm216311e87.6.2025.02.27.09.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 09:44:17 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 27 Feb 2025 18:44:15 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <Z8Ckb6spK35-Ez4U@pc636>
References: <20250227131613.52683-1-urezki@gmail.com>
 <20250227131613.52683-3-urezki@gmail.com>
 <Z8CdB0Hzvdu5ZVSI@Mac.home>
 <d8b196c1-c1b5-4bf9-b1cb-dde8642cc34b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8b196c1-c1b5-4bf9-b1cb-dde8642cc34b@paulmck-laptop>

On Thu, Feb 27, 2025 at 09:26:40AM -0800, Paul E. McKenney wrote:
> On Thu, Feb 27, 2025 at 09:12:39AM -0800, Boqun Feng wrote:
> > Hi Ulad,
> > 
> > I put these three patches into next (and misc.2025.02.27a) for some
> > testing, hopefully it all goes well and they can make it v6.15.
> > 
> > A few tag changed below:
> > 
> > On Thu, Feb 27, 2025 at 02:16:13PM +0100, Uladzislau Rezki (Sony) wrote:
> > > Switch for using of get_state_synchronize_rcu_full() and
> > > poll_state_synchronize_rcu_full() pair to debug a normal
> > > synchronize_rcu() call.
> > > 
> > > Just using "not" full APIs to identify if a grace period is
> > > passed or not might lead to a false-positive kernel splat.
> > > 
> > > It can happen, because get_state_synchronize_rcu() compresses
> > > both normal and expedited states into one single unsigned long
> > > value, so a poll_state_synchronize_rcu() can miss GP-completion
> > > when synchronize_rcu()/synchronize_rcu_expedited() concurrently
> > > run.
> > > 
> > > To address this, switch to poll_state_synchronize_rcu_full() and
> > > get_state_synchronize_rcu_full() APIs, which use separate variables
> > > for expedited and normal states.
> > > 
> > > Link: https://lore.kernel.org/lkml/Z5ikQeVmVdsWQrdD@pc636/T/
> > 
> > I switch this into "Closes:" per checkpatch.
> > 
> > > Fixes: 988f569ae041 ("rcu: Reduce synchronize_rcu() latency")
> > > Reported-by: cheung wall <zzqq0103.hey@gmail.com>
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > 
> > You seem to forget add Paul's Reviewed-by, so I add it in rcu/next.
> > Would you or Paul double-check the Reviewed-by should be here?
> 
> I am good with keeping my Reviewed-by tags.
> 
Thanks Paul!

--
Uladzislau Rezki
