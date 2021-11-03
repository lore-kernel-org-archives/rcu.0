Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962DEC433FE
	for <rcu@archiver.kernel.org>; Wed,  3 Nov 2021 08:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B9FA60E9B
	for <rcu@archiver.kernel.org>; Wed,  3 Nov 2021 08:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhKCI1l (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Nov 2021 04:27:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:5860 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231338AbhKCI1k (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Nov 2021 04:27:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10156"; a="317656776"
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="scan'208";a="317656776"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 01:25:04 -0700
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="scan'208";a="449981309"
Received: from jzhuge-mobl.ccr.corp.intel.com (HELO [10.167.226.45]) ([10.255.31.103])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 01:25:01 -0700
Subject: Re: [PATCH 4/6] scftorture: always log error message
To:     paulmck@kernel.org
Cc:     dave@stgolabs.net, joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, rostedt@goodmis.org,
        rcu@vger.kernel.org, philip.li@intel.com, lizhijian@cn.fujitsu.com,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
References: <20211029094029.22501-1-zhijianx.li@intel.com>
 <20211029094029.22501-5-zhijianx.li@intel.com>
 <20211102160656.GI880162@paulmck-ThinkPad-P17-Gen-1>
From:   Li Zhijian <zhijianx.li@intel.com>
Message-ID: <15e9b661-d61b-f555-b16e-671a4aabc8db@intel.com>
Date:   Wed, 3 Nov 2021 16:24:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211102160656.GI880162@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 03/11/2021 00:06, Paul E. McKenney wrote:
> On Fri, Oct 29, 2021 at 05:40:27PM +0800, Li Zhijian wrote:
>> Generally, error message should be logged anyhow.
>>
>> Signed-off-by: Li Zhijian<zhijianx.li@intel.com>
> I have queued the patches up to this point for the v5.17 merge window
> (not the current one, but the next one).
>
> This one does not apply.  It looks like you created it against mainline
> rather than -rcu.  You can learn about the -rcu tree and its habits here:
>
> https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/rcutodo.html
>
> Please port this patch to -rcu so that I can pull it in without
> conflicting with patches in -rcu.
Glad to know this, i will rebase the rest 2 patches and resubmit them soon.

Thanks
Zhijian


>

