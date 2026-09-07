Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8FC50AC28
	for <rcu@vger.kernel.org>; Mon,  7 Sep 2026 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796041; cv=none; b=K4T/CXp3gyzctFLqwGDzWuCFongA/Le1dk7/Kdh7lYuXSCzgN6jigGZD+79PXPPim+iAh4PFZON46Wa1FlZQezYxNo+TQe+xSmr08RyyIeNDXG033raWory0bxkesYhtjNeh2A9HS+C02VZxE5sT1IwUIFeV0+jVRwF6oV9IGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796041; c=relaxed/simple;
	bh=/hqGRwDn3gn18VWIUgAvVWOCvccvyWq95BKIpNRdFtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXQTNCR2vo5R9SaSeAqa7nuSr6xD3KTCAdPcQxUDz30K2mK0p+AGRvHsdx3M8Z9ER8olbtv+Nu8tLeb+XqasgLsOUy9gf7IRpaCSYAw1YrV8BzuydvFSheSsWtkcRW0Oh+RqsO16w8sD6M/fFfqqHAHf6h0RU9ktsyci9YUtkww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cBK2c+zG; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cBK2c+zG"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-90cd8e45460so54268516d6.1
        for <rcu@vger.kernel.org>; Mon, 07 Sep 2026 08:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788796038; x=1789400838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mmDZvfc6UbCMaSCl3e5zbW7Me/bO13UXyky9OUcj+5c=;
        b=cBK2c+zGYEBMAfyAYJS/QQdrfqd7izx/+Cg8hDXP1IONC0/uGrnS2Wo6s7Gyw03PeE
         bmy7F1sQdHddDujNvmb67dvr3s77U6jZ+JI0u9nBlughfKTWoYTJgfg/PDSCQ8m84C9J
         Hdg52YFcBmofcI5F4cLltT+Msszbmvno0MrvrR6DziA7CChNrUpzEBgBT8Tj+S366Mgh
         HsAu5NOKRTz2LqRpaA82xB3X294iKQt6TrXFv+zSiicPYXJgRrAfzLneQ3xikl9jdnOC
         5ijNYANwE5rCujgJ+U12jnsedELi7ao/rajeeB7tucCXg4C3hhaU2YFtUZ7/ycknJNIf
         6TUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788796038; x=1789400838;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mmDZvfc6UbCMaSCl3e5zbW7Me/bO13UXyky9OUcj+5c=;
        b=Jn6VTf8dn/Wzd1UT+jIuRo+wi4377Qmk78sQKUwakLDF5nUPq8RjJ6IHGnCUkv1ABX
         EVJfaGS357GnawnAZHsT8Ips/pSUn1baDbxnOGQ9mlQWFbu8wBJjT/Enq2Gdw71HyHwR
         AKOFQral2m5qfYm6B+Y1WdRZx/45KfuEl015RP/wfZfCWVelIUvNhJaWsdFBo2AYTuOK
         UI3XdOtm7Mryj+t6NvFHZMFwhWSYe9e6aqELuLWYAD8cpA4vBOk5yi54V/jdmksNRzUh
         5dPzyjQqnpjpT0sxcD8hLZaqoNH386uu8+ZtIi2mrXBXCz5BQnxnXn44fxPB56VlBwS7
         IDlA==
X-Forwarded-Encrypted: i=1; AKwUvBy1bdhSv8AjsSDBrdAreI61HWqQZF7GFabxTpdGCc5exeKzE4cU7d7r08jPd+jR6i+1nJs=@vger.kernel.org
X-Gm-Message-State: AFuF++kyd6j34UEn5UOelIGoZJLWmbUiS/iQ1TvnfEvEaGeWsK4QQLXW
	fewfA5XpxSArxKUc2VMoAsa6oqcvKUN99vEIbjQuS+ttIl9CvB5GeDHE24MvRYlnOmU=
X-Gm-Gg: AYBFou1zkyUPRBmNlL6+3XznaRSBIO0vOFahGNgdQQtPExkgBn23+g+A5MKt5n06SX/
	tAsfqERf8hjPoBAcAeJHfDzIcT4FH+nNbkHxQG6JPk7oxz3LXiO6LybxOu4go5bQxnk4ynCbBts
	iDGHpzFe1gDV5Rk7VOP4q27K+dRHt8edKv3f/nZurQ9SEdA+6XYW09wwbfnuX+MENe71swIZXFw
	/UUehdWpQOUhwYC10oPhc2ua7lWqv2NWEa0Z2EFT9kTbdA6ce0Lpr74vR6GBvrBy64ni+zLk3UK
	jGQJDOqfXEh6WeWV+Y99P/LkMgE1hoLnEQBdKezWS4UdqCD97Dt5kdqy1kDnxRgidQurKjHEmax
	iV1lcYEHI21+Ri8zxYWnfpJCPG+gu8eyZ/qhpTji5RhRl1HK0650NOrmwI3KbbO/xzVv/AiyVra
	x+D88DM4y98kyWh59XxPQOEgDxoVrDMkzSU8PahvNBPho3SuxtSyxBSX0EdUzrsyUSxdUAqQGcH
	c2N4STNyooX+X27N65saMZdQdOpw5UD3t+5GA48Kg8U
X-Received: by 2002:a05:6214:2b87:b0:910:4861:43ac with SMTP id 6a1803df08f44-910486145aemr202492056d6.5.1788796038419;
        Mon, 07 Sep 2026 08:47:18 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406afe48sm94174406d6.43.2026.09.07.08.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:47:17 -0700 (PDT)
Date: Mon, 7 Sep 2026 11:47:15 -0400
From: Gregory Price <gourry@gourry.net>
To: Ye Liu <ye.liu@linux.dev>
Cc: Tony Luck <tony.luck@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org, Christian Brauner <brauner@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, "David Hildenbrand (arm)" <david@kernel.org>, 
	Alexey Dobriyan <adobriyan@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Ye Liu <liuye@kylinos.cn>, Michal Hocko <mhocko@suse.com>, 
	peterz@infradead.org, paulmck@kernel.org, mingo@redhat.com, rostedt@goodmis.org, 
	jpoimboe@kernel.org, mic@digikod.net, tglx@kernel.org, linmiaohe@huawei.com, 
	nao.horiguchi@gmail.com, rafael@kernel.org, gnoack3000@gmail.com, sj@kernel.org, 
	rientjes@google.com, shakeel.butt@linux.dev, xu.xin16@zte.com.cn, 
	chengming.zhou@linux.dev, will@kernel.org, boqun@kernel.org, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, pavel@kernel.org, lance.yang@linux.dev, 
	mhiramat@kernel.org, pmladek@suse.com, longman@redhat.com, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, qiang.zhang@linux.dev, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, 
	babu.moger@amd.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 6/8] fs: convert process/thread iterators to
 for_each_*_rculock
Message-ID: <ap7cd8OigImcG6eX@gourry-fedora-PF4VCD3F>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-7-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907081334.1152889-7-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:32PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace the manual rcu_read_lock()/rcu_read_unlock() pairs combined
> with for_each_process() and for_each_process_thread() loops in fs/
> with the for_each_*_rculock() macros, which scope the RCU read lock
> to the loop body via scoped_guard(rcu).
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

