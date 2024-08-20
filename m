Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFFA18E345;
	Tue, 20 Aug 2024 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724169764; cv=none; b=joh3zevQwv8skhRNX9a57aM4z4HIHTwh+R5AEiX/FNxNqUuXOLwoyn+NXKi5tX6Vl0FfWD1xeE9HHF0gEkZoLC3cof07rYrBH1aPyJkumXajENIRwyaq06ChbqAsHxvXEbiPehyFFmOdcW6qvUEq15blSn5F9GGMYfAb1/p1mPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724169764; c=relaxed/simple;
	bh=OoCi1kiPCSXYTldXmmjDlyxqOulBjE/ZG+sniKlk+oU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJjMQHXxKxxQaZauJ5JyuLCI+7GzzlMPJ4tHbAyYxLojpSNVY5ub8rirgCszc8DaqAYu87PFC2OpyINuap7khgmKhAgj5yMwNiYnFIq6BCjWexxa0RsggLJG3X4vO/LdK7LqKwTKKE9SJSB9hAGmkM/WdTq3VL7HYUxgxGlQd6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILCfyyon; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILCfyyon"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53345604960so529462e87.3;
        Tue, 20 Aug 2024 09:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724169761; x=1724774561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H6SCEVIACYGUuKiOlfM8plsiG93dGJNmKrdwRKLr5bQ=;
        b=ILCfyyonqDMY/cqIJor9xs8+L1MEebu6FZgQv6Qt3JYB/MVNJZxf3XFqPdgsL0Dthp
         24xzPkiiTj0Ckk3KoF2Yy+u8qWMXQ9qjsHBfZJBt871mvFtex7/WwXbVB+mBJ5H3J1CL
         093nmHDEXXA/f1tNtHu3wrx9vIyPAbQgtjQDIdD3v4U90efJzAp6TgY0/cFTKBP27svu
         irntADDqHDLTbHeWZ83Pr1BnklnkCsUNFbqCy1afw7OAGj3wUt6XL6D+YAjFzh4JkLJP
         TCV7EUvenh9xsC2KR8/x0ZaOEoO4fkuwiWxVw228Nl8JV4WAQTSc8Dax0CQEZVhC4DI2
         SHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724169761; x=1724774561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6SCEVIACYGUuKiOlfM8plsiG93dGJNmKrdwRKLr5bQ=;
        b=ZKgekW/OaL2gDXywYbBX1rAM81Za7GgbN5+d7OPjxN4X1LqN/rMkHHvSidEq6A42n5
         ZP+Cu39IUIXppKbkXfKok4ubYG0km4J1dn7tfLDsTVsCfvY1z9qTfbYXx7xYW3CQpQQ6
         vghoKzmBC2NypTgumtKNQKcv6PlUJz34Wi3KIJY4uXY//FSLXhxrj++WYgBHRtwCdPga
         +gCuvsHuBNvk3tPPg/C4BQkk+3nh/c+VBBeCtP6Tpmh1Q+jIBD1VKyAwsVpCdFHA6F2l
         22n92dURhRnNtT+46CgmX8vl5JVITd9lLLcpAzxDIHgQlnwps5/qWfWbESFqogSD8vcL
         xyig==
X-Forwarded-Encrypted: i=1; AJvYcCUngHs68OiN3SdzhsPNmAbu0cdU5BNiBxaLCuAG03fuTyWewEVLq5IWrBjVOZdi9jtgQIN4iwiBL/yK8Rs=@vger.kernel.org, AJvYcCV/hQSBarAyJImoo6pZ5BjV0VWk6vTNzUOh0y+13QuApFGZ3BSxTJfAqcRPDMOa/cWq3iSn@vger.kernel.org
X-Gm-Message-State: AOJu0YwdpaAbj0lDGJROyYNvK04TH/4Sk52ploY6lL4hqXw3oEJ9p5tS
	VLKWAS8CANSsu2xC9ZcGtDBvprWu7pNVOnLBDBSaVZ1HHfTlJvwk
X-Google-Smtp-Source: AGHT+IHKII37H4/4fww4WqoVJiYZYF+QrbpAHY8zZEfaWaL5dhrcfO/JbOGJPCr6+7YCKGNbg1A6Tw==
X-Received: by 2002:a05:6512:3085:b0:533:809:a970 with SMTP id 2adb3069b0e04-5331c6a20e1mr9584254e87.14.1724169760015;
        Tue, 20 Aug 2024 09:02:40 -0700 (PDT)
Received: from pc636 (host-90-233-193-131.mobileonline.telia.com. [90.233.193.131])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5330d3afd26sm1814968e87.12.2024.08.20.09.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:02:38 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 20 Aug 2024 18:02:34 +0200
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com, Jann Horn <jannh@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v2 5/7] rcu/kvfree: Add kvfree_rcu_barrier() API
Message-ID: <ZsS-GiHF8QZ929Vn@pc636>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-5-ea79102f428c@suse.cz>
 <ZrZDPLN9CRvRrbMy@pc636>
 <6a6c1c59-eee3-4263-9cad-53b57d78c018@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a6c1c59-eee3-4263-9cad-53b57d78c018@suse.cz>

Hello, Vlastimil!

> On 8/9/24 18:26, Uladzislau Rezki wrote:
> > Hello, Vlastimil!
> > I need to send out a v2. What is a best way? Please let me know. I have not
> > checked where this series already landed.
> 
> Hi,
> 
> you can just send it separately based on v6.11-rc2, as you did v1 and I will
> replace it in the slab/for-next. Thanks!
> 
Sorry for delay. I had a vacation last week. Just posted the v2 with a fix.
Now my tests are passed!

Thanks!

--
Uladzislau Rezki
