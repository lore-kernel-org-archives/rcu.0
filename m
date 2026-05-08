Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36853D565B
	for <rcu@vger.kernel.org>; Fri,  8 May 2026 18:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778264774; cv=none; b=VtBopsIdGTM9kxpdP0nekzGPQx+zYQBd8ZlAxaAaC44YtsWRxLO5fy/rYdHCflLQDxPJkBG6UZGxw7vZpQZr20CgZQeBXekraHyt57RlVxmI7PNakMZ//rQnsPp/d5vnziIdglREHGwAhPeBFYstPDjqcW7ePxsVohrUtBwSf2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778264774; c=relaxed/simple;
	bh=gPt2p5mRydIx09aB5eoi5h+EjR87ILB07pmtiyqKD6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECR7b9wx7NHSI0WUtWJy8mx7fWaiWaW3J9/P6BN/cmiCIWweOBxqj8wKe+nMT7lZvFLHIcVoCLJrfW/S732lyt3BqakYSx4bpFWuwE147gEXYMOQALl+9Bcpy5ANBjh8vcq1iZgRolveKidnnZ/YHtuPw9Z44Ir2NVKBJ508StI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UH89eDTW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH89eDTW"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so1420139f8f.0
        for <rcu@vger.kernel.org>; Fri, 08 May 2026 11:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778264770; x=1778869570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nadJ4F3fO0o2IbMhIzDipftu6czfRb7SQ9fGD7WtGtQ=;
        b=UH89eDTWQh9OmS5hUj/dgbTfi3H7wYOPLAD09tyOadceQmuQ1jSW8ecpWt6e65vzgO
         dUPuw2rKBsNlxygqwzKdECs3V10qe9a4JTkf9GaWDDLwqBqvoMNLKQ2z3FbIsAL/Xdkv
         h7/yFvPjCarOyc2epdk5HYzixl3aB5dJ7/MAOl6vWwy/FkzEklri+HmlVblgJNeywYs3
         jY4s5DAbrSwYKbkt8b7zGAZBoJzpLJWvDWX8ghQ6HhC4QCi71rcwijca/mxruMoHZWW5
         w3gPGRNJQkqEZa35nbPwNKiM05kM5CZ5Ih7Ano8akSmPY2OogTfMOuflpNXAGNBjiHZS
         1bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778264770; x=1778869570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nadJ4F3fO0o2IbMhIzDipftu6czfRb7SQ9fGD7WtGtQ=;
        b=FLc2XSZS1X1THVNgXiZt/tpbQ6tw8Crw+mptuXxTekknRrG+EWjDSetWSK40y0a584
         hG+irWUS6erUwCEWHY7zB2kemT0b94bsGzsfXnw4xADBq0/dkbdUGnTdvPBoW92+CYMS
         Ee93mvkbdEWxWVvU8ES65bhuyxXHC+gHPG4oEtHvYFhPeZ270ZMU8D+2zVoPo3yExAyr
         BuxNdPOvkLlfVZa++VSkzDUGX+QwfuFOpWseJu2nNIi7B3GgAf/qYKlHHuXOOj+MBsiW
         U8gJYQOwySAmybSubjeHxCNypnpmMeHAp4yzjnXPz0/9YJP5Fq5e0B8zJJbEcxL4oIUJ
         UosQ==
X-Forwarded-Encrypted: i=1; AFNElJ8uxoRgZ44OtgO2yg+OKJKGcEW+/EuwPv+sk82gCgUswzXU1PHSHBang8UstYpnrz7IGLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpZdAFjUzPrzNSo0WEeYeO28cMD4Q0r3WNgGuwUB3traM2vnDU
	Zp4DIhCHw1oWGOSWPUBU/Qmr6ptHfkw6YuJ9YBQJyypTFV2NPWWAO3oN
X-Gm-Gg: Acq92OEGC2AxERcK7fARcDbTH8TeqCF3E38WzQBS+avannPYr8NlNG6q33t9tNuiPpV
	5WFq3T2Lx1xzI5qd/CBRk3zcv5cOa9OGtwl/AAoCfNuNbI/6+zyoWFg8Bb6aeo0ceeC4FT0wk9S
	tsYheCHrGkfMgDPZTenI9Z/+C++bRVN0NYdpKXAOeCJQWplyUu5o/TUtoi29uzsTzWH7jOPWbIg
	gpf6rdr/tDX7JtFahGMhhSw2ChKVnYfj7xEdINWTH4qiPthwluH4dUmEL2egu+rmc2gdm9M5cvQ
	ZNgfRBtVpJkxXZLOjkiUM5KG5lYlQPTGz4hg1pPNE6qk5VfhfP2WFvbzAeU48g9WrRHdh0jg+yT
	dE7QotPv6v2ZQFdkpd6wU9GgOumDONrbMsfhBRJn8l/AZpXXM51XFZCDTRZPdfQI51ZVvGWB0Hf
	XsbQJ9521efNpMl+CuFheWHBjE6qvoym2rdA9TjjBIlXDdfqIzACwRb+mcbHTR7KFD
X-Received: by 2002:a05:6000:420c:b0:43d:7508:c9c9 with SMTP id ffacd0b85a97d-4515c5752d8mr22366137f8f.27.1778264770073;
        Fri, 08 May 2026 11:26:10 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6c79fsm6435208f8f.15.2026.05.08.11.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 11:26:09 -0700 (PDT)
Date: Fri, 8 May 2026 19:26:06 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Adrien Reynard <reynard.adrien.08@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
 <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, David Howells <dhowells@redhat.com>,
 Paulo Alcantara <pc@manguebit.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 "open list:READ-COPY UPDATE (RCU)" <rcu@vger.kernel.org>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:DRIVER CORE, KOBJECTS, DEBUGFS
 AND SYSFS" <driver-core@lists.linux.dev>, "open list:FILESYSTEMS [NETFS
 LIBRARY]" <netfs@lists.linux.dev>, "open list:FILESYSTEMS [NETFS LIBRARY]"
 <linux-fsdevel@vger.kernel.org>, "open list:TRACING"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] docs: fix repeated word 'that' across documentation
Message-ID: <20260508192606.2423f50e@pumpkin>
In-Reply-To: <1501caea-8cff-4968-aca6-e8d4b20e0e80@linuxfoundation.org>
References: <20260508163759.16231-1-reynard.adrien.08@gmail.com>
	<1501caea-8cff-4968-aca6-e8d4b20e0e80@linuxfoundation.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 May 2026 11:15:28 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 5/8/26 10:37, Adrien Reynard wrote:
> 
> Missing commit log in all your patches - I don't patch 1/5 in
> my Inbox.
> 
> > Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
> > ---
> >   Documentation/RCU/rcu.rst                          | 2 +-
> >   Documentation/driver-api/driver-model/overview.rst | 2 +-
> >   Documentation/filesystems/netfs_library.rst        | 2 +-
> >   Documentation/trace/histogram-design.rst           | 2 +-
> >   Documentation/trace/histogram.rst                  | 2 +-
> >   5 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
> > index bf6617b330a7..320ad3292b75 100644
> > --- a/Documentation/RCU/rcu.rst
> > +++ b/Documentation/RCU/rcu.rst
> > @@ -32,7 +32,7 @@ Frequently Asked Questions
> >     Just as with spinlocks, RCU readers are not permitted to
> >     block, switch to user-mode execution, or enter the idle loop.
> >     Therefore, as soon as a CPU is seen passing through any of these
> > -  three states, we know that that CPU has exited any previous RCU
> > +  three states, we know that CPU has exited any previous RCU  
> 
> The original intent might have been to say, "that cpu", so adding
> the missing comma after the first "that" or change "that" to "the"
> would make sense.
...

I don't think adding a comma would be correct.
The clause splits as 'we know that' 'that CPU' and the repeated 'that'
is absolutely correct.
Maybe 'that CPU' could be replaced by 'it'; but it can be difficult to
work out what back references like 'it' refer to.

You can re-order it, as (say):
	Therefore we know that as soon as a CPU is seen passing through any of these
	three states it has exited any previous RCU read-side critical sections.

But just because some grammar book says you shouldn't have repeated words
doesn't mean there aren't exceptions.

The sign writer was doing a new sign for the 'Pig and Whistle'.
Unfortunately the gaps between Pig and and and and and Whistle
ended up visibly different.

-- David


