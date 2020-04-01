Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68941C43331
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 07:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5F82071A
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 07:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585725004;
	bh=kzem1Bc2AHbTTQjVnBgBGysf8SzYnGXPZklGbiFzjso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ot8sORXe+k8wPe+9EsI2Hw0sQxChpyGTnyavieTBAJNjZNfSd+4/XGIg46gLGGpB8
	 054Jt5m8oPGwunHbKhZXYVl7hksIjJ3BTYkPy7ce6Nep835DCjEUbpxyMoqmEMkS/9
	 A5Ws0HYfYUk9DxRCQAK3+GYJHJCuJ/1sK87oZaIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbgDAHKE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 03:10:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51162 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731823AbgDAHKD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 03:10:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id t128so5381408wma.0;
        Wed, 01 Apr 2020 00:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tKcCvBkl/5wFmhqyWXdNyuguB+1XgXDUmUQ8zhlCfl0=;
        b=GimWW9vahLRTeKGDBwlaxrahNw06822ARp9fna0DxzM+KxmbLJ/v2mT1rj5pvcL5w+
         CyVkT6whSkyl3bLHD74RRKwVnPQEMLY8+9Um0/+A/5KP7p7Z4LhrOEfFS1IrMFE3cRv/
         OWvTPVIh/5RfN2HFykkj51lqDaL+eeO+ZukJeBf6QFFm8TIAAvAo5a13QJughJrqmxqn
         o86FhKk4Pv0I+olbesVuwzNe+4lEJlJjFV3M2CZTtjVqVL51NMWv58rRdOAjTPrD6s81
         fjaA+Zrs1NzykRLoR5SwEcSf5TdpqDWgUcUl+KtTcqHwDC6XD73eORDGsN5vzDmUDF4Z
         sdWA==
X-Gm-Message-State: AGi0PuZaSk2bpgbFWYwjRF36q2Sz+AQS9UdNFhHXKwELUEFNjB852Rvz
        w99NF3o70Y/1Zh6YJNAdIes=
X-Google-Smtp-Source: APiQypJKzF9JIQqbmrZ1L+OJq9oATJtUV+U+TwMIOVFC0ButeSV7aj/VbyF6MRit5GbMNX5BdI0M+Q==
X-Received: by 2002:a7b:cb59:: with SMTP id v25mr2931801wmj.13.1585725001425;
        Wed, 01 Apr 2020 00:10:01 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id f141sm1517974wmf.3.2020.04.01.00.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 00:10:00 -0700 (PDT)
Date:   Wed, 1 Apr 2020 09:09:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, willy@infradead.org, peterz@infradead.org,
        neilb@suse.com, vbabka@suse.cz, mgorman@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200401070958.GB22681@dhcp22.suse.cz>
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331145806.GB236678@google.com>
 <20200331153450.GM30449@dhcp22.suse.cz>
 <20200331161215.GA27676@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331161215.GA27676@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue 31-03-20 18:12:15, Uladzislau Rezki wrote:
> > 
> > __GFP_ATOMIC | __GFP_HIGH is the way to get an additional access to
> > memory reserves regarless of the sleeping status.
> > 
> Michal, just one question here regarding proposed flags. Can we also
> tight it with __GFP_RETRY_MAYFAIL flag? Means it also can repeat a few
> times in order to increase the chance of being success.

yes, __GFP_RETRY_MAYFAIL is perfectly valid with __GFP_ATOMIC. Please
note that __GFP_ATOMIC, despite its name, doesn't imply an atomic
allocation which cannot sleep. Quite confusing, I know. A much better
name would be __GFP_RESERVES or something like that.

-- 
Michal Hocko
SUSE Labs
