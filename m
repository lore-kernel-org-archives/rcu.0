Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7CA22A7ED
	for <rcu@vger.kernel.org>; Wed,  5 Feb 2025 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738747733; cv=none; b=L/wppHwT7eviLTzehGwjx0Ga9A9a6st7HPMBrFrVtds/R32JK4KAYXGktg2O+tOFS3h+Aw/4V0DH8AH+53o4XBDthHNhg1K5B/8nNHVg5r88biqoAVX+cwo5DDTeXZkcmC3BaamDDWomYqq+L8eOhEkvoxFEv1kS/WgiLVKo9eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738747733; c=relaxed/simple;
	bh=s+feehdjvacWB5vZQP1hA8n/kiq5ZqfFh7Yi9F3h6JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYGfUl9qs6aDaGN1zKSnXt5cX7XWkV6CBB9JxTAGzMdrOa/J0vI27PzOi4WbyYb4+r5MBa+3KJYvzWxyJWZxb0Aiw+X+vrBgwGc8BJAoz+ROKA8wGm1WF016+f36E9DUcMuLasTydVS9SwoUQqQMb5j9cT3yO7cwJUvk+nrEGaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEl6Pj5x; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEl6Pj5x"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f20666e72so3064505ad.1
        for <rcu@vger.kernel.org>; Wed, 05 Feb 2025 01:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738747731; x=1739352531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cRbxoMBzUG+hvulzwE2ajAZiA+/UrsVptxvsnAuNkP0=;
        b=iEl6Pj5x3cxEiPEokDJOsn7Gh5lnFwncSWJF6uBbG/m0HR/0UFJbDSRw1kEaBljFhl
         theSupQAJbpL8QWH7XiQzbrL2Dz8g2d9lK3rS49JJMtl0XdvxaF7G5gNiwBeiWgDQob1
         XDWn5uKM01YCa4+nFdTbdZor99CZU0JG4/k8Y2sG7Vdur84LIGoAT3xHK/5NWEKYs5aR
         fQ0w9CKOUUmomVWaRSELVHXpvhL1diXY5I5HzW0ItdSKuC0EVjJtodypB3VbCXAp+2Og
         qGWSdotKzy63iIzRr0PNGhKJYLWUt4EHRiP50MZzXAgBs/EP0h30hb/KvkAMesJN9NX3
         NjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738747731; x=1739352531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRbxoMBzUG+hvulzwE2ajAZiA+/UrsVptxvsnAuNkP0=;
        b=QL7xUjbOlig/TtwszopoutxXlxXIdMppLUplMvdIJhfpbjOBoHYzhsnDYEMKDy7rgu
         NfvPyVwDwmzvcug/Rw944JJjL9/AFXMzZk3Z3dvYwEjR8tUcVme/djyrBqwa3af1JsFc
         9Ip5WE8kSHs2AjnidN9wq0xysDeFbOv7/4eZMTIiRqi6QD+oGfGB8O7ro51p+CKyOtF3
         0/vOvHthTyrxPkm8bCakTfuCU3ww4Qo/HgvLfmDOg/VC+nXb8loO4QGBj3Ns7gQkvIro
         fsVFE+wJKNzj2IEuOxING8f2qY89fkgaR3aXmBEhMbesS9hJPrI4w5Tatjz/1Tm4F00R
         DlLw==
X-Forwarded-Encrypted: i=1; AJvYcCXWtAMAdbRtt+x7tGQYWdsxVolKPQ/SjN8k1Kb8gGApfyA3ITcdJqNrVBuUQc3wX7abHx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgFFvSZzo7jhAo3Ij5GmDwdykKwamOqj7AtwNwYdxGJ9gtRb+y
	S1X8Hfh3ob1/kEnfgVt0DWFoNfMGNkUZLOOL3cNdRm7kPqWke4NO
X-Gm-Gg: ASbGncsn+A1bSIFp/cEnfLfKpefgvsuPTToVJdwvLbYHT0dJkTIzBrMCzIMC+1J14Uc
	vfftZCTB37JXeVfO0VHD+p8KEPvZvJSu/jM/Hr40R/0cj5BzozvhM/Kx9TCIa9Dlv5dRBAu4vLQ
	ir7I0PSQPiZtXIgS8RZiuWdht7hG2+lbJw3sObXRcYW/i9kgUaGpIyQnPofgmbydIUc60CXFwgU
	M21iF3Qi1OAoADz7PhfhzjFCz0og4oQEu5EE6pzRXosbKDlH7m8bAzcqxl6TBb6hHR0/XyTS1uv
	tlKekAPUvxqLiYZ7ddyJlYxi1yhZjZPfjG6I0TU=
X-Google-Smtp-Source: AGHT+IFcrwCJs2Pn94HAzxRnEGQiSa/iTsozumTzxE23W3954tdRVZhsZX74IDtIJf+fPRjtP0Jdkw==
X-Received: by 2002:a17:902:e541:b0:215:6fcd:6cd1 with SMTP id d9443c01a7336-21f17e2716cmr31457365ad.7.1738747730637;
        Wed, 05 Feb 2025 01:28:50 -0800 (PST)
Received: from MacBook-Air-5.local ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f13a8221csm13539575ad.122.2025.02.05.01.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 01:28:50 -0800 (PST)
Date: Wed, 5 Feb 2025 18:28:41 +0900
From: "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 2/4] rcu: remove trace_rcu_kvfree_callback
Message-ID: <Z6MvSf24WA5-r5oM@MacBook-Air-5.local>
References: <20250203-slub-tiny-kfree_rcu-v1-0-d4428bf9a8a1@suse.cz>
 <20250203-slub-tiny-kfree_rcu-v1-2-d4428bf9a8a1@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203-slub-tiny-kfree_rcu-v1-2-d4428bf9a8a1@suse.cz>

On Mon, Feb 03, 2025 at 10:28:48AM +0100, Vlastimil Babka wrote:
> Tree RCU does not handle kvfree_rcu() by queueing individual objects by
> call_rcu() anymore, thus the tracepoint and associated
> __is_kvfree_rcu_offset() check is dead code now. Remove it.
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

-- 
Harry
