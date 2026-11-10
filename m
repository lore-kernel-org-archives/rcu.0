Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794287226;
	b=EQ4eb3rC4WteFoL2QoZ4QBIALEt2apsfrXTgCn9kEIzudfQ+Ea0nN/t6vt8XUVcGg/f8
	 AFyWDdfqtMBAWtKd3J9zhcxEjVmHd8L8LjW7zDg3C5ODoeAbQY4demuX3a3c4/YJRgPpA
	 RBotSaJu8mS02tPTn85wjZpNM1naRqV2mjLXFJS7FugT7tbJEOhQuJ3Q1yH5UuNo+Nvbl
	 1nPCIFX3hIC80UPnwok/qWexG+x493jAoXgVg6osM/0udDnLEOB2BqNJoqmdzshvcxhlv
	 ziGH2v/ZHbDQFAkbDajgPSGvcK816Qmiki3BKSLt3sTrdU+7z3fM2Acw96VIJZTILsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287226;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=2seNUxR80lWFNHMOtGuOcjLvb6hw83oNlRxRNGGUWvE=;
	b=gwZDgfTbclyCQT4h5HEgEj4Kc3RpRAPvpU2vx28T5xQ4oMXXGq3R7kqmtuqLxjx5Z9Gu
	 4RxxJVy3ID5w49Ytc1i2DJiU/3Q3Tzdt7lT2iyQTBwiaNQMWX1wUrW2aMf549SIQzeSTe
	 bLSYgvgOeU5z8+geDt4n9pt4j/xvrmU1xsLAGFdwoz2PD0jobie517rd/UztvbowJnRyt
	 l+F2SYrRorlvGv4O2yrDXSg6wCobqJEoTOWqcE2zcE0wmhc3QhVMjdnNQPlHMU1Ti6yKy
	 +9/evY23ODyYCdFITX1T1Hn5LDBdzqUR1drJRiKePoMjXZslNmnVLjCuNhD7SLZdN0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=cryspen.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8C8606A32E
	for <rcu@vger.kernel.org>; Tue, 10 Nov 2026 05:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD8C8606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryspen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-492690dd5daso1062255f8f.1
        for <rcu@vger.kernel.org>; Mon, 09 Nov 2026 21:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794287224; x=1794892024;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2seNUxR80lWFNHMOtGuOcjLvb6hw83oNlRxRNGGUWvE=;
        b=O9nXdhQ2SHAnhw9WzNXQYNQCVZP7ns6uamnoN8aHTXQiTIF/C9PA7nKhz9S/IMyyyh
         exTSVxM2u6mIvK61SHLlCgMUBUwKzr5VEI5Ht/BKYuUZmnWeLde8lao6qYJ3tCF70HEv
         h69PSW2Faj8ORIDtG1IJKyt8T6v5T/iXQMyzmM3WdZ8HTLNAcFvI8j/YTVB30/zTBbN1
         9XxIWwC2vzN0wo2OTLxBDJ6T8886IpdPDEqPK5vFfvwUV1WOAPkJ4tUD0/URsJ46QbaT
         oLMcSLrI+Wzvf+baRtJs/MTWy7ovDqWnqu56yq6u7KncKe0AI8JzUzXInA00DudmMDCN
         bu1w==
X-Forwarded-Encrypted: i=1; AL+hErGHAzcaUmE5BnVhr8eW4NbpDqHrP1wvkQeKfJ/Mcp62TrVucFYIXybM48KJ+stE+WDATzA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9e7/iwwri6TuaEtsRveioYa+YPY6WsxaLvmy1Jy+thNr7k9Mdb
	uG5Nr1xgXYz+hz1Ym/CI4Nkli/U0zV/nqghFujuruuDsvWQx7SlWbkGf
X-Gm-Gg: AYBFou2lscn+iVUQUQGJNW3YZ702FiE8V3g20qysgBoJje28VnDOUaQYgWSLzRFyVNm
	2JN34/epSv/117LglFPFZZryYpZnk9MO733bTQwr9nvDzCLI/PuNcAjUyLpTWW0pqcqe/q/h6+g
	YDaSEXnil5dtZbAFloRrulu9ZUA+RsfXsacqVOnCWgUDniiI58/plVxZ9KX+kQFImXMrqqEAL40
	s6jHcMnvi24/tVx42PyaZc88eqZZoyjd9+2hcQFhsSVbIVLIxQXZXa5MEgtlL3npclcsY8Dpns2
	4UPLoPe5Kr2/uOLakaUFOv+NRA4RTFI5AYh6ZMX+PHD+aNy05HLyw3W6bwMM04vo3NS2W3E9Dsx
	YdgCrnz/ZYm7jGygrIuwwSaFL4WDZf25kSQH1D/F8d3rjs5VikoLVSFfn+b25lyCpTAlec6vqw8
	K0iLQ1yV20lhmzwcqOo/DvHJMfLMymMNMEBfoiilzu00fXkb3wzFRpqdntQwk2EqOxkWj9+fNAQ
	obBTZGwbiFWClAS3eqsCsxOKC1iZAeqwr7Npm/+KEPQVcL9V5f4/mdLJhhLRmFqP1y9NpchOc9r
	1ACC/KEYMpKOYUyvQ6Y8kPei4mcW/vhWItOiHSsm6KmmOJBxG1XzbG2OHHtLLY2HwWzLzTcz2h3
	5y3vrV2SuIm4rxeDC0+NTc5Pl+8Lm+6w2vTROUtvpVHROL95/3pqMyEqmSfcKFK0+h3GRWj25a/
	dE0DZaWsNvFA==
X-Received: by 2002:a05:6000:25fb:b0:48c:7f18:c85e with SMTP id ffacd0b85a97d-498305da14amr2288609f8f.45.1794287223902;
        Mon, 09 Nov 2026 21:07:03 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4988bdef64dsm1332172f8f.20.2026.11.09.21.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 21:07:03 -0800 (PST)
Date: Tue, 10 Nov 2026 08:06:59 +0300
From: Dan Carpenter <dan@cryspen.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcuscale: Constify struct rcu_scale_ops
Message-ID: <avKmc-690MOAGJc5@stanley.mountain>
References: <3f546f8e102ef271e7d5ac6d8b6a1f44d0fb20cb.1794085327.git.christophe.jaillet@wanadoo.fr>
 <20261108230623.GA3148953@joelbox>
 <2727df26-9f09-48c9-90b5-2d1416c3b2b1@wanadoo.fr>
 <730e60cb-30fd-43a3-8152-543b4ba5878e@paulmck-laptop>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <730e60cb-30fd-43a3-8152-543b4ba5878e@paulmck-laptop>

On Mon, Nov 09, 2026 at 10:44:16AM -0800, Paul E. McKenney wrote:
> On Mon, Nov 09, 2026 at 06:32:15PM +0100, Christophe JAILLET wrote:
> > Le 09/11/2026 à 00:06, Joel Fernandes a écrit :
> > > On Sat, Nov 07, 2026 at 10:02:25PM +0100, Christophe JAILLET wrote:
> > > > 'struct rcu_scale_ops' is not modified in this driver.
> > > > 
> > > > Constifying these structures moves some data to a read-only section, so
> > > > increases overall security, especially when the structure holds some
> > > > function pointers.
> > > > 
> > > > On a x86_64, with allmodconfig:
> > > > Before:
> > > > ======
> > > >     text	   data	    bss	    dec	    hex	filename
> > > >    45585	  24946	   2816	  73347	  11e83	kernel/rcu/rcuscale.o
> > > > 
> > > > After:
> > > > =====
> > > >     text	   data	    bss	    dec	    hex	filename
> > > >    46545	  23986	   2816	  73347	  11e83	kernel/rcu/rcuscale.o
> > > > 
> > > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > > ---
> > > > Compile tested only.
> > > 
> > > rcuscale is a test kernel module, is it worth adding boilerplate for
> > > non-production code sighting security reasons?
> > 
> > Oups, now I better understand Bradley Morgan comments.
> > 
> > I didn't notice it was a test module.
> > My patch makes no more sense, as it is not hardening runtime, so feel free
> > to just drop it.
> > 
> > Sorry for the noise and not seeing it by myself.
> 
> Although the header comment does say "Read-Copy Update module-based
> scalability-test facility", maybe there is something that should be
> done to more clearly mark code that is not to be used in production.
> And maybe to inform the LLM review bots of this.
> 
> But this is bigger than just RCU.

Christophe has been constify things for years and years.  There is
an argument to be made that it's just the right thing to do whether
this is test code or not.  Someone might copy and paste it, for
example.

Of course, everyone is overloaded with AI.  I feel like normal cleanup
patches are more likely to get NAKed because everyone is just totally
overwhelmed.

regards,
dan carpenter

