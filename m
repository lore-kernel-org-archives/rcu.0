Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0006C22256C
	for <rcu@vger.kernel.org>; Sat, 16 Aug 2025 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755329243; cv=none; b=Om8IKmxp3Eb5gKiDIODeE04pw4JCU4VrHvw/8QHZYEC+CffxyOVDq5iyx205ZKMtaPdCXZyMIFltwxJhddxajFC1TiFz9I3cExhMz6dJTl0csCnZuWsyYrw41mfoJbFrLQ9O3E9y29DHD3m8BWUH0aoacxoySh37WOno6wydCMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755329243; c=relaxed/simple;
	bh=6t+pWXtNvn3PngcOHMQ0az8IKzQqpXpauzoUr3nAI3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlI9l/z+EmQD5wmWf1QUcCRkFYhKLnOmVItG8g8ciIB+1wb8JK5kVw+5Z1mL/Gxnf+SSs/pQQNEJu6VpYW6tbbOQwAnawJTJNqab9/aM8nAx/I/r1I5QjEvLKWSaFOMooHJL1FVOukZ8BpI2/nDVSDWj3svuU80CiOCsajAvch0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fQ0sK/hx; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fQ0sK/hx"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb78fb04cso413423666b.1
        for <rcu@vger.kernel.org>; Sat, 16 Aug 2025 00:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755329236; x=1755934036; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FpiVReBk4pxi7WdSyaid9+sMC8akMMwfHAVHbbVirOA=;
        b=fQ0sK/hxNVwmGst+oxWhkC/dXmt6K/rFa859hVG8g47Zycx0qEC1R8nZoswGF1Hwz/
         jn8e1pBPnzIWD16izOjpOy8eDVvdmvgiqgdD6zO66cEEQXLIOB+dzgCHJqI77/x/V75D
         WKqU6wqV+lQyzGbECZ8Uhg/vnz9NrKkaewXIqO+tBpW8ZZGoEsCv0iPO3T/8pEQV232M
         heAao2AHf4HeKbyIX2OkWQu68voSvoA+7BIi32p6WS4MPJN9EbyIif7ki0VS44SWf7aN
         f1KLlGL3dXdVrT4eeuz3VdyY5ilo9N+DxPHx6Z1hB0Id6BRM5inOTUKXh3A3RaUFpcOy
         lPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755329236; x=1755934036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpiVReBk4pxi7WdSyaid9+sMC8akMMwfHAVHbbVirOA=;
        b=uoFcFXBTTvqFeBFvZqEL3kcStXKyQQVJ2iqLpQwD8rXBHCP4a0kmz8CcdzjgSfpbfv
         aVmfHOSoR5yHSWDMB5feS1zgZ04cWBb89Ycy1jvy71PEA8vt0wwchfySrO0YNA+n9SmV
         1ykUb0qkPldaa4q83VnJa9YTWVZ0Vnw9/Qgdcx4Rmcrj2OItJpj0fCQo4ZIlqoutzhRy
         JddkcTJ0Gm49gt2hCyMAtSeq7KMHClOXSrutMiTvKkOIqOG8mf6R54PmWZ0iXlaSQjDs
         7FAqk6EMjhQi8qBpq3Z9rVKQQmmHKWJ3ra4JsrpN+6QjMP0WXw7bCcMPxNV5Fs/iUbUO
         6DYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0n0hNSQ3PUo8Pct5dN7WjXGrkW9gFwZumj9xdRUl7IrDEKokjQ53JugfK095Gfps5O5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq9zXTrpqa6WErDpgfZ3onhzwL+3Pn5Jt2l4r1b5n5h+ieOYh9
	45eGa9wi82LYkReaZscn0YD5blsudKIzShS45ZJ1sT9EMfgTLIZyzKrOFnG5jtPzBA==
X-Gm-Gg: ASbGncuypJvgEOEHAFw7AiAkKesLmopNf2W577oajUS22eIHIsqJMl/Uo9P6N4HJslz
	OcPVEKRo/nPlzuYyGwbbXmGyhyPm2Sor+Lb1ODKryFFdrG+rg+v3pUTr7qd6aigMLTidVw7d5wt
	tM5e9/kBT/JW4silSwofn8qk7GzCKkR0z/fF83vBiKPYxkr2+VxukwK8cilFcD2mTYBswXrMFqE
	qtuFK0XOtTKgGR69+OA2/3ReYwWccjWG+VQ0r+6SWv5nhds2XBqvjeUdaG8cRVVdWgBVamZuqmx
	ZsJu/sVqG8Jt70H7f2en3sEJcYASDU0g4Z6aZdNW2H1N7UdXx7M4YtnCMDKPN04X2V+s/meevzF
	Y6uItCqCZIG8=
X-Google-Smtp-Source: AGHT+IFg7imxaFEagNP0U5Ayia7U3tygLpXsVf6xKmyOpZitxVfNDophojGzUA2/MzddJEvPpEzhfA==
X-Received: by 2002:a17:906:6a0f:b0:ae8:4776:fbb1 with SMTP id a640c23a62f3a-afcdc03d360mr411785966b.11.1755329236202;
        Sat, 16 Aug 2025 00:27:16 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdcea179esm312796166b.57.2025.08.16.00.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 00:27:15 -0700 (PDT)
Date: Sat, 16 Aug 2025 07:27:14 +0000
From: Wei Gao <wegao@suse.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	Menglong Dong <menglong8.dong@gmail.com>, kraig@google.com,
	lkp@intel.com, netdev@vger.kernel.org, dsahern@kernel.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	edumazet@google.com, horms@kernel.org, oe-lkp@lists.linux.dev,
	kuba@kernel.org, pabeni@redhat.com, ncardwell@google.com,
	davem@davemloft.net, ltp@lists.linux.it,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: Re: [LTP] [PATCH net v2] net: ip: order the reuseport socket in
 __inet_hash
Message-ID: <aKAy0nu2p6X9sKUw@localhost>
References: <20250801090949.129941-1-dongml2@chinatelecom.cn>
 <202508110750.a66a4225-lkp@intel.com>
 <aJ_qbZDvDJwVoZGA@localhost>
 <CAAVpQUCEGiRjoobf69Jd5M9vnZyi0N6crNUgSBpDTGNfrap1cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUCEGiRjoobf69Jd5M9vnZyi0N6crNUgSBpDTGNfrap1cA@mail.gmail.com>

On Fri, Aug 15, 2025 at 07:35:10PM -0700, Kuniyuki Iwashima wrote:
> On Fri, Aug 15, 2025 at 7:18 PM Wei Gao <wegao@suse.com> wrote:
> >
> > On Mon, Aug 11, 2025 at 01:27:12PM +0800, kernel test robot wrote:
> > >
> > >
> > > Hello,
> > >
> > > kernel test robot noticed "BUG:KASAN:slab-use-after-free_in__inet_hash" on:
> > >
> > > commit: 859ca60b71ef223e210d3d003a225d9ca70879fd ("[PATCH net v2] net: ip: order the reuseport socket in __inet_hash")
> > > url: https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/net-ip-order-the-reuseport-socket-in-__inet_hash/20250801-171131
> > > base: https://git.kernel.org/cgit/linux/kernel/git/davem/net.git 01051012887329ea78eaca19b1d2eac4c9f601b5
> > > patch link: https://lore.kernel.org/all/20250801090949.129941-1-dongml2@chinatelecom.cn/
> > > patch subject: [PATCH net v2] net: ip: order the reuseport socket in __inet_hash
> > >
> > > in testcase: ltp
> > > version: ltp-x86_64-6505f9e29-1_20250802
> > > with following parameters:
> > >
> > >       disk: 1HDD
> > >       fs: ext4
> > >       test: fs_perms_simple
> > >
> > >
> > >
> > > config: x86_64-rhel-9.4-ltp
> > > compiler: gcc-12
> > > test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory
> > >
> > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > >
> > >
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202508110750.a66a4225-lkp@intel.com
> > >
> > >
> > > kern :err : [  128.186735] BUG: KASAN: slab-use-after-free in __inet_hash (net/ipv4/inet_hashtables.c:749 net/ipv4/inet_hashtables.c:800)
> >
> > This kasan error not related with LTP case, i guess it triggered by network
> > related process such as bind etc. I try to give following patch to fix
> > kasan error, correct me if any mistake, thanks.
> 
> Note that the report was for the patch in the mailing list
> and the patch was not applied to net-next.git nor net.git.
Thanks for note. 
Since this email sent to LTP group so i got this. Since
i'm interested in this 'kasan' problem, so trying to fix it.
> 
> 
> >
> > From: Wei Gao <wegao@suse.com>
> > Date: Sat, 16 Aug 2025 09:32:56 +0800
> > Subject: [PATCH v1] net: Fix BUG:KASAN:slab-use-after-free_in__inet_hash
> >
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202508110750.a66a4225-lkp@intel.com
> > Signed-off-by: Wei Gao <wegao@suse.com>
> > ---
> >  include/linux/rculist_nulls.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
> > index da500f4ae142..5def9009c507 100644
> > --- a/include/linux/rculist_nulls.h
> > +++ b/include/linux/rculist_nulls.h
> > @@ -57,7 +57,7 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
> >   * @node: element of the list.
> >   */
> >  #define hlist_nulls_pprev_rcu(node) \
> > -       (*((struct hlist_nulls_node __rcu __force **)&(node)->pprev))
> > +       (*((struct hlist_nulls_node __rcu __force **)(node)->pprev))
> >
> >  /**
> >   * hlist_nulls_del_rcu - deletes entry from hash list without re-initialization
> > @@ -175,7 +175,7 @@ static inline void hlist_nulls_add_before_rcu(struct hlist_nulls_node *n,
> >  {
> >         WRITE_ONCE(n->pprev, next->pprev);
> >         n->next = next;
> > -       rcu_assign_pointer(hlist_nulls_pprev_rcu(n), n);
> > +       rcu_assign_pointer(hlist_nulls_pprev_rcu(next), n);
> >         WRITE_ONCE(next->pprev, &n->next);
> >  }
> >
> > --
> > 2.43.0
> >
